package com.makeit.utils {
	/**
	 * @author quhuan
	 */
	public class TreeNode {
		private var data:Object;
        public var isLeaf:Boolean;
        public var parent:TreeNode;
        public var value:String;
        public function TreeNode(){
                data={};
                isLeaf=true;
        }//end of Function
        public function getChild(name:String):TreeNode{
                return data[name];
        }//end of Function
        public function setChild(key:String):TreeNode{
                var node:TreeNode = new TreeNode;
                data[key]=node;
                node.value=key;
                node.parent=this;
                return node;
        }//end of Function
        public function getFullWord():String{
                var rt:String = this.value;
                var node:TreeNode = this.parent;
                while(node){
                        rt=node.value+rt;
                        node=node.parent;
                }//end while
                return rt;
        }//end of Function
	}
}
