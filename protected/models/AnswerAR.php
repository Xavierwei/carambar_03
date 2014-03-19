<?php

/**
 * This is the model class for table "answer".
 *
 * The followings are the available columns in table 'answer':
 * @property string $aid
 * @property string $answer
 * @property string $answer_value
 * @property string $answer_count
 */
class AnswerAR extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'answer';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('answer, answer_count', 'required'),
			array('answer, answer_value', 'length', 'max'=>255),
			array('answer_count', 'length', 'max'=>10),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('aid, answer, answer_value, answer_count', 'safe', 'on'=>'search'),
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
			'aid' => '问答题aid',
			'answer' => '问题',
			'answer_value' => '问题答案',
			'answer_count' => '问题答对数',
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

		$criteria->compare('aid',$this->aid,true);
		$criteria->compare('answer',$this->answer,true);
		$criteria->compare('answer_value',$this->answer_value,true);
		$criteria->compare('answer_count',$this->answer_count,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return AnswerAR the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}


    /**
     * 获取列表
     */
    public function getAnswerList($limit=8,$offset=1)
    {
        $query = new CDbCriteria();
        $query->limit=  $limit; //每页显示条数
        $query->offset= $limit * ($offset-1); //偏移计算
        $res = $this->findAll($query);
        return $res;
    }

    /**
     * 获取随机一条数据
     */
    public function randOne()
    {
        $query = new CDbCriteria();
        $query->order='rand()';
        $query->limit=  1; //每页显示条数
        $res = $this->find($query);
        return $res;
    }
}
