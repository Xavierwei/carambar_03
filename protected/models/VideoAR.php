<?php

class VideoAR extends CActiveRecord{


	public function tableName() {
		return "video";
	}

	public function primaryKey() {
		return "vid";
	}

	public static function model($class = __CLASS__) {
		return parent::model($class);
	}

    public function rules()
    {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('url, title, thumbnail, datetime, status, position, mid', 'required','on'=>'create'),
            array('status, position', 'numerical', 'integerOnly'=>true),
            array('url, title, thumbnail', 'length', 'max'=>255),
            array('datetime', 'length', 'max'=>11),
            array('mid', 'length', 'max'=>50),
            array('rank', 'length', 'max'=>6),
            array('phase', 'length', 'max'=>30),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array('vid, url, title, thumbnail, datetime, status, position, mid, rank,phase', 'safe', 'on'=>'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations()
    {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels()
    {
        return array(
            'vid' => 'Vid',
            'url' => 'Url',
            'title' => 'Title',
            'thumbnail' => 'Thumbnail',
            'datetime' => 'Datetime',
            'status' => 'Status',
            'position' => 'Position',
            'mid' => 'Mid',
            'rank' => 'Rank',
            'phase' => '阶段',
        );
    }


	/**
	 * Check mid is already post
	 * @param $attribute
	 * @param array $params
	 * @return bool
	 */
	public function uniqueMid($attribute, $params = array()) {
		$count = self::model()->findByAttributes(array("mid" => $attribute));
		if ($count) {
			return false;
		}
		else {
			return true;
		}
	}

	public function afterSave() {
		$name = 'video'.$this->vid;
		$ext = pathinfo($this->thumbnail, PATHINFO_EXTENSION);
		$newname = $name.'.'.$ext;
		$paths = explode("/", $this->thumbnail);
		$paths[count($paths) - 1] = $newname;
		$newpath = implode("/", $paths);
		if (file_exists(ROOT.$this->thumbnail) && $ext) {
			rename(ROOT.$this->thumbnail, ROOT. $newpath);
			$this->updateByPk($this->vid, array("thumbnail" => $newpath));
			$this->thumbnail = $newpath;
		}
		return TRUE;
	}


	/**
	 * Get youtube id from url
	 */
	public function getYoutubeId($url) {
		$params = NodeAR::model()->getUrlParams($url);
		if (isset($params) && isset($params['v'])) {
			return $params['v'];
		}
		else {
			$shoturl =  explode("/",$url);
			if(isset($shoturl[3])) {
				$id = explode('?', $shoturl[3]);
				return $id[0];
			}
		}

		return false;
	}


	public function getVideoList($position=NULL,$status=1,$limit=8,$offset=1,$phase) {
		$query = new CDbCriteria();
		$query->addCondition('status=:status');
		$query->params[':status'] = $status;

        if(NULL!=$position) //为空显示全部
        {
            $query->addCondition('position=:position');
            $query->params[':position'] =$position;
        }

        $query->addCondition('phase LIKE :phase');
        $query->params[':phase']='%'.$phase.'%';

        $query->order='rank ASC'; //按照排序
        $query->limit=  $limit; //每页显示条数
	    $query->offset= $limit * ($offset-1); //偏移计算
		$res = $this->findAll($query);

		return $res;
	}




}
