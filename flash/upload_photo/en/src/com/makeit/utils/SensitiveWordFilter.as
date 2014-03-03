package com.makeit.utils {
	/**
	 * @author quhuan
	 * 查找敏感词汇
	 */
	public class SensitiveWordFilter {
		private var treeRoot:TreeNode;
        public function regSensitiveWords(words:Array):void{
                //这是一个预处理步骤，生成敏感词索引树，功耗大于查找时使用的方法，但只在程序开始时调用一次。
                treeRoot=new TreeNode();
                treeRoot.value="";
                var words_len:int = words.length;
                for(var i:int = 0;i<words_len;i++){
                        var word:String = words[i];
                        var len:int = word.length;
                        var currentBranch:TreeNode = treeRoot;
                        for(var c:int = 0;c<len;c++){
                                currentBranch.isLeaf=false;
                                var char:String = word.charAt(c);
                                var tmp:TreeNode = currentBranch.getChild(char);
                                if(tmp){
                                        if(tmp.isLeaf){
                                                throw new Error("长词在短词后被注册。已经有以("+tmp.getFullWord()+")开头的敏感词存在,当前正在注册第"+i+"个词("+word+")");
                                        }//end if
                                        currentBranch=tmp;
                                }else {
                                        currentBranch=currentBranch.setChild(char);
                                }//end if
                        }//end for
                        if(!currentBranch.isLeaf){
                                throw new Error("短词在长词后被注册。已经有以("+word+")开头的敏感词存在,当前正在注册第"+i+"个词");
                        }//end if
                }//end for
        }//end of Function
        public function findSensitiveWordsIn(og:String):String{
                var ptrs:Array = new Array;//嫌疑列表，但凡前几个字匹配成功的节点都放在这里
                var len:int = og.length;
                var tmp:TreeNode;
                for(var c:int = 0;c<len;c++){
                        var char:String = og.charAt(c);
                        //如果嫌疑列表内有数据，先对其进行检验，检查char是否是嫌疑列表中某节点的下一个字
                        var p:int = ptrs.length;
                        while(p--){
                                var node:TreeNode = ptrs.shift();
                                tmp=node.getChild(char);
                                if(tmp){
                                        if(tmp.isLeaf){
                                                return tmp.getFullWord()+" @["+c+"]";
                                        }//end if
                                        //从node开始，敏感词的下一个字也被匹配到，并且已经完整地匹配了一个敏感词，可以返回
                                        ptrs.push(tmp);
                                        //从node开始，下一个字也匹配到了，但还没有完整地匹配一个敏感词，那么将下一个字的节点压入嫌疑列表
                                }//end if
                        }//end while
                        //之后从treeRoot开始查找。因treeRoot的子项是所有敏感词的第一个字，这里在尝试匹配是否有与char相同的敏感词第一字
                        tmp=treeRoot.getChild(char);
                        if(tmp){
                                if(tmp.isLeaf){
                                        return char+" @["+c+"]";
                                }//end if
                                //如果是一个字的敏感词，直接返回
                                ptrs.push(tmp);
                                //如果匹配上了非单字敏感词的第一个字，那么将其加入嫌疑列表
                        }//end if
                }//end for
                return null;
        }//end of Function
	}
}
