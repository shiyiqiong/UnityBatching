Unity版本：Unity 2022.3.17f1c1。
***
合批分类：
- SRP Batcher（可编程渲染管线合批）；
- Static Batching（静态合批）；
- GPU Instance（GPU 实例化）；
- Dynamic Batching（动态合批）。
***
优先级：SRP Bacher > Static Baching > GPU Instancing > Dynamic Baching。
***
实现原理：
- SRP Batcher（可编程渲染管线合批）：相同shader，draw calls时，在显存中缓存材质属性，尽量减少CPU向GPU传递数据，从而提交渲染状态切换时效率。
- Static Batching（静态合批）：相同材质，构建项目时，合并静态网格，从而减少draw calls。
- GPU Instance（GPU 实例化）：相同网格和材质，不同位置和材质属性，通过数组将转换矩阵和材质属性从CPU传递到GPU缓存起来，直接在draw calls中，通过对象实例ID获取对应矩阵和材质属性，进行绘制。
- Dynamic Batching（动态合批）：相同材质，在运算时，动态合并网格，从而减少draw calls。
***
适用条件：
