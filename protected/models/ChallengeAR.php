<?php

/**
 * This is the model class for table "challenge".
 *
 * The followings are the available columns in table 'challenge':
 * @property string $cid
 * @property string $title
 * @property string $image
 * @property string $datetime
 * @property string $vote_counts
 */
class ChallengeAR extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'challenge';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('title', 'length', 'max'=>128),
			array('image', 'length', 'max'=>256),
			array('datetime', 'length', 'max'=>11),
			array('vote_counts', 'length', 'max'=>13),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('cid, title, image, datetime, vote_counts', 'safe', 'on'=>'search'),
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
			'cid' => 'Cid',
			'title' => 'Title',
			'image' => 'Image',
			'datetime' => 'Datetime',
			'vote_counts' => 'Vote Counts',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('cid',$this->cid,true);
		$criteria->compare('title',$this->title,true);
		$criteria->compare('image',$this->image,true);
		$criteria->compare('datetime',$this->datetime,true);
		$criteria->compare('vote_counts',$this->vote_counts,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ChallengeAR the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

    /**
     * @return array
     * 返回list信息
     */
    public function getChallengeList()
    {
        $query = new CDbCriteria();
        $query->select = "cid,title,image,vote_counts";
        $res = $this->findAll($query);

        $list = array();
        foreach($res as $item) {
            $vote['cid'] = $item->cid;
            $vote['title'] = $item->title;
            $vote['image'] = $item->image;
            $vote['vote_counts'] = $item->vote_counts;
            $list[$item->cid] = $vote;
        }

        return $list;
    }

}
