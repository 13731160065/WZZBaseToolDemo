业务类文件
====

本文件下所有文件均为临时测试类，可以全部删除，建议在该文件夹内按文件夹进行大小业务划分，在每个业务中再做mvc或mvvm等架构细粉

**tmpViewController.h/.m**
临时测试类，可以删除

**SafeAreaDemoVC**
临时测试类，可删除

**WZZTmpView**
临时测试类，可删除
该视图展示了如何在xib中使用WZZSuperXibView，以便于xib的复用
1. 创建自定义view继承自WZZSuperXibView
2. 创建view对应的xib
3. 将file‘s owner的class设置为view（不用将view的class设置为view，这块区别于直接创建view关联的xib）
4. 将file‘s owner的wzz_xibView属性拉至view即可
5. 使用时可参照tmpViewController中的视图，新建一个UIView设置好约束，将class设置为你的自定义view即可
