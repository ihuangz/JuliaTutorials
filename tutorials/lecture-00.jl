### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
# ╠═╡ show_logs = false
begin
	using PlutoUI
	using Plots
	using HypertextLiteral
	using LaTeXStrings
	using Printf
end

# ╔═╡ 57b08715-dda4-46f7-bb5a-f868491be8eb
md"""
## Initial settings
"""

# ╔═╡ 5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
PlutoUI.TableOfContents(title="目录",aside=true)

# ╔═╡ 232c59fa-77b2-470c-ae85-fa8e8b14c301
njubox="https://box.nju.edu.cn/f"

# ╔═╡ aaa0f3cc-f507-4f12-a611-0560fe8ecb24
begin
	struct Foldable{C}
	    title::String
	    content::C
	end
	function Base.show(io, mime::MIME"text/html", fld::Foldable)
	    write(io,"<details><summary>$(fld.title)</summary><p>")
	    show(io, mime, fld.content)
	    write(io,"</p></details>")
	end
end

# ╔═╡ 818bbfd3-181a-49fa-8e11-e61fc921cee8
Foldable("hide ones", 
	
	md"""
	blablabla
	
	"""
)

# ╔═╡ 400ae1f1-4ee9-4f48-9fda-1f46918c452c
begin
	struct TwoColumn{L, R}
	    left::L
	    right::R
	end
	function Base.show(io, mime::MIME"text/html", tc::TwoColumn)
	    write(io, """<div style="display: flex;gap:20px"><div style="flex: 50%;">""")
	    show(io, mime, tc.left)
	    write(io, """</div><div style="flex: 50%;">""")
	    show(io, mime, tc.right)
	    write(io, """</div></div>""")
	end
end

# ╔═╡ c663c599-239d-4e5a-9d4b-2337eda0d6ba
TwoColumn(md"Note the kink at ``x=0``!", md"This is right column.")

# ╔═╡ 6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]));

# ╔═╡ 69d6d08f-b03f-4975-9974-6daacbf2576f
hint(md"danger, warning, info/note, and tip")

# ╔═╡ 08282040-eefc-4d50-b842-f2117e071f49
html"""
<style>
.alert {
  padding: 20px;
  background-color: #CCCCCC;
  color: white;
  opacity: 1;
  transition: opacity 0.6s;
  margin-bottom: 15px;
}

.alert.red {background-color: #f44336;}
.alert.green {background-color: #04AA6D;}
.alert.blue {background-color: #2196F3;}
.alert.orange {background-color: #ff9800;}

</style>

<h4>Alert Messages</h2>

<div class="alert orange">
  <strong>anyone!</strong></br> Indicates a dangerous or potentially negative action.
</div>

<div class="alert red">
  <strong>Success!</strong></br> Indicates a successful or positive action.
</div>

<div class="alert green">
  <strong>Info!</strong></br> Indicates a neutral informative change or action.
</div>

<div class="alert blue">
  <strong>Warning!</strong></br> Indicates a warning that might need attention.
</div>

"""

# ╔═╡ a94a1f96-59ea-4447-a9e6-d3012549259c
md"""
`a = ` $(@bind a html"<input type=range >")

`b = ` $(@bind b html"<input type=text >")

`c = ` $(@bind c html"<input type=button value='Click'>")

`d = ` $(@bind d html"<input type=checkbox >")

`e = ` $(@bind e html"<select><option value='one'>First</option><option value='two'>Second</option></select>")

`f = ` $(@bind f html"<input type=color >")

"""

# ╔═╡ 205a4f51-11c1-4b5e-8cf2-049cefe8c702
md"$\LARGE\color{red}以上是本Notebook的一般设置$"

# ╔═╡ 007546fe-f8aa-45b1-b46f-7b5fcf70749c
md"""
## 课程安排
!!! tip "课时组成"
	* 理论课： 3学时（黄周传）
	* 实验课： 1学时（米宁）
	* 助教： 杨漂

!!! tip "成绩组成"
	* 平时（10）+实验（30）+期末（60）
	* 课程讲义纠错： 5分浮动

!!! tip "上课形式"
	* 理论课： Julia编程语言、Pluto Notebook （定量化分析、绘图）
	* 实验课： 计算机程序、仪器操作、报告撰写
	* 课程QQ群： 580126768
"""

# ╔═╡ eaa37388-46e0-41aa-9587-30ea849eaeca
md"""
## Julia notebook: 交互式编程展示
"""

# ╔═╡ a5275d80-81a0-44bb-87ea-10e0ae1dd7bd
@bind t Clock(0.5)

# ╔═╡ 99932797-1e49-4233-9c02-8f8524233a7e
@printf("The value of t is: %d", t)

# ╔═╡ 1ad4d977-ed65-4170-a175-927efc57b18b
begin
	x = -20:0.01:20
	y = 1sin.(2x .- t)
	z = 3sin.(3x .- 2t)
	plot(x,y+z)
	xlabel!(L"x")
	ylabel!(L"y+z")
	title!(L"y=\sin(2x-t)+3\sin(3x-2t)")
end

# ╔═╡ fbcfaf3a-4497-4274-a162-4b6a05bda333
md"""
## 课程内容
"""

# ╔═╡ c9f377ff-15e7-4414-ae88-b531fba2c947
TwoColumn(md"""
!!! warning "绪论-1"
!!! note "地震学-10"
	* 地震分布
	* 地震波传播
	* 地震波走时曲线
	* 地震面波
	* 地震观测系统
	* 反射波探测方法
	* 折射波探测方法
	* 地震层析成像
	* 地震各向异性
	* 地震震源机制
!!! tip "重力学-4"
	* 地球重力场
	* 异常体重力场
	* 重力校正与重力异常
	* 重力异常数据分析

""", md"""
!!! tip "地磁学-3"
	* 地球磁场
	* 异常体磁场
	* 磁异常数据分析
!!! tip "地电学-3"
	* 电阻率方法
	* 极化电场方法
	* 电磁场方法
!!! warning "地球物理综合能力提升-x"	
	* 深地幔结构研究
	* 地核结构研究
	* 碰撞带结构与动力学
	* 俯冲带结构与动力学
	* 洋中脊结构与动力学
	* 地震灾害与防震减灾
	* 地下资源勘探开发
	* 近地表空间环境探测
""")

# ╔═╡ 350c6713-c16a-4888-850c-281dcc03837a
md"""
# Lecture 1: 绪论
"""

# ╔═╡ 54bab2e3-c118-4833-9354-0ac1fafde563
@htl"""
<h2> 1.1 地球物理学概述：历史</h2>
<ul> 
	<li> 地球物理(<span style="color:red">geophysics</span>，德语为 geophysik)一词最早于 1834 年出现在德语中，是 由 Julius Frobel 提出的。1887 年，“Beitrage zur Geophysik”杂志诞生， 地球物理 一词开始正式出现在文献中。</li> 
	<li> 1898 年，University of Göttingen 建立了世界上第一所 地球物理研究所，Emil Wiechert 教授成为第一位地球物理机构的负责人。</li> 
	<li> 1919 年， 世界上第一个地球物理国际组织“International Union of Geodesy and Geophysics”在 比利时布鲁塞尔成立.</li> 
	<li> 1957~1958 年举行的“International Geophysical Year”活动对地球物理学的发展具有里程碑的意义，确立了包括地震学、地磁 学、重力学在内的 11 个相关学科，建立了现代地球物理学的学科框架。</li> 

</ul>

<p style="display: flex; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/cd9bf6598dfc47b088d0/?dl=1" height="200" style="margin:auto">
<img src="https://box.nju.edu.cn/f/1828a40a320b448796cd/?dl=1" height="200" style="margin:auto">
<img src="https://box.nju.edu.cn/f/280ad449effa4cd39262/?dl=1" height="200" style="margin:auto">
</p>

"""

# ╔═╡ 2bd81ac7-e680-4e18-a830-cf5d4e99d914
md"""
## 1.1 地球物理学概述：定义
"""

# ╔═╡ 0fd05b4a-7721-43df-89c6-d84e9e302858
TwoColumn(md"""

- 地球物理学是**以地球为研究对象**的一门现代**应用物理学**，其主体是**固体**地球物理学，研究地球表面的各种物理场、地球内部的物质组成、结构和运移、地球深部过程和动力学及其对地表演化的影响等。
- 广义的地球物理学包括固体地球、水圈循环、海洋和大气流体动力学、大气层的电磁作用，以及相近行星系统的物理性质
- **本书**特指固体地球物理学，它是地球科学的一个重要分支，通过对地球物理场的观测，利用物理、数学和计算机技术，定量研究固体地球内部的物理性质与物理过程。
"""
, @htl """
<p>
<img src="https://box.nju.edu.cn/f/baecb7cc380e42bea272/?dl=1" height="380" style="margin:10px">
</p>
"""	
)

# ╔═╡ eb0b78f3-3dbc-4d8c-9099-c87b6238f30d
md"""
## 1.1 地球物理学概述：内涵
!!! info "地球物理学是地球科学与物理学的结合"
	- 从**物理学**的角度上讲， 地球物理是物理学方法在地球科学研究中的应用;
	- 从**地球科学**的角度上讲，地球物理是一种技术手段。
!!! info "不同维度上的地球物理学"
	- **研究方法：**利用数学和物理学的方法
	- **研究内容：**研究固体地球介质的物理性质、空间分布和时间演化
	- **空间尺度：**关注人类无法直接到达的固体地球内部
	- **时间尺度：**现今时间节点上的地球结构和状态，是地球演化过程的边界约束
![](https://box.nju.edu.cn/f/ffb3b7259c6a42bca974/?dl=1)
"""

# ╔═╡ 6470342a-66a9-4b3b-96e8-becab3f727ee
md"""
## 1.1 地球物理学概述：贡献
!!! danger "地球物理学的观测和研究成果对地球科学基本理论的发展起到了重要的推动作用"
"""

# ╔═╡ cc4d17e0-c839-4430-84fc-76860c67d434
TwoColumn(md"""
!!! info "板块构造基本框架理论"
	- 地磁学海底磁异常条带: 关键证据
	- 贝尼奥夫地震带: 板块俯冲
"""
, md"""
!!! info "地球科学理论的突破和发展"
	- 板块深俯冲与超级地幔柱
	-  $\color{red}超越板块构造$
"""	
)

# ╔═╡ 9d737090-1290-488a-8e59-b50f4222658c
html"""
<p style="display: flex; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/f9bfb0913a1f4edc8ca7/?dl=1" height="350" style="margin:10px">
</p>
"""

# ╔═╡ 22e278e6-b66e-4dff-9710-b9297540f7a9
md"""
## 1.1 地球物理学概述：贡献
!!! info "地球物理学与人类社会息息相关"
	- 为研究地震和火山源区的结构提供了重要探测手段，是研究和阐明自然灾害成因和成灾机制的基础
	- 为煤炭、石油、天然气等各种能源资源、 金属和非金属矿产资源的开发提供了丰富的勘探手段，发挥着不可替代的作用
	- 为水利水电、道路交通、地下空间开发等基础建设工程， 探明地下的地质结构，查明基岩、断裂、水文分布状况
	- 广泛应用于航空航天、军事和国防安全领域，保障国家战略安全
"""

# ╔═╡ 6b7c9cbb-36f8-4f73-8cf9-d6a876f1145d
html"""
<p style="display: flex; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/6f730c95627a4dc0866b/?dl=1" width=600>
</p>
"""

# ╔═╡ 09ca25f6-5239-466c-88ce-b79bb65c9444
md"""## 1.2 研究内容
!!! tip "研究尺度"
	!!! info "大中尺度的地球本体结构和性质"
		- 各种地球物理场的全球时空分布规律
		- 地球的形状和内部圈层结构
		- 震源物理过程
		- 地磁场起源
	!!! info "中小尺度地质体为对象的应用研究"
		- 油气资源勘探
		- 金属与非金属勘探
		- 工程勘探与环境监测

!!! tip "研究对象"
	- 地震波场 <==> 地震学 <==> 弹性模量、密度、速度结构
	- 重力场 <==> 重力学 <==> 密度结构
	- 地磁场 <==> 地磁学 <==> 磁性结构
	- 地电场 <==> 地电学 <==> 电性结构
	- 地热场 <==> 地热学 <==> 地热结构

"""

# ╔═╡ 821ea226-1fc8-4410-a53a-447114d87bd4
md"""## 1.2 研究方法"""

# ╔═╡ 48eb1246-c087-4801-9a46-35b2a9ce74fb
html"""
<p style="display: flex; flex-direction: column; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/8567a21a652a47bbbb7c/?dl=1" width=500>
<img src="https://box.nju.edu.cn/f/b4e0044ae141418a904b/?dl=1" width=600>
</p>
"""

# ╔═╡ 7ff8a6cb-5e96-4b0b-8dcd-69c4e733ac53
md"""## 1.2 研究方法： 正演与反演"""

# ╔═╡ 78e2ff57-7dcd-4256-aec8-31c8e58027d0
html"""
<p style="display: flex; flex-direction: column; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/72def8dc5ef04d53ab42/?dl=1" width=300>
<img src="https://box.nju.edu.cn/f/4d254e9bbe234986b791/?dl=1" width=500>

</p>
"""

# ╔═╡ 3e4612c4-9c31-4f2f-90b4-e177348dd9d8
md"""## 1.2 研究方法： 正演与反演
!!! note "正演与反演相辅相成"
	- 正演过程提供地球物理场分布特征的一般性和规律性认识
	- 反演获得的参数模型需要通过正演计算理论物理场进行验证
	- 比较计算场与观测场 $\Rightarrow$ 修订参数模型 $\Rightarrow$ 逼近真实地球结构
	- 正演和反演交替进行: **地球物理最基本的工作方法**
!!! note "反演的不唯一性"
	- 地球物理场等效性： 不同的场源或者结构可以形成相同的场效应
	- 信息具不完备性: 实际的观测资料是对地球物理场的稀疏采样
	- **多参数、多方法**的联合反演和**多学科资料**的综合解释，以降低反演的多解性，获得对研究对象的正确认知
"""

# ╔═╡ 764a44e8-6536-458e-aeb8-1e1a5ea12b47
md"""## 1.3 地球基本结构： 观测
$\Large\color{red}地球内部结构\leftrightarrows地球物理场$
* 温度、压力 $\Rightarrow$ 矿物组分 $\Rightarrow$ 密度、速度、磁性、电性、导热... 
* 地球的形状： 大地水准面
![](https://box.nju.edu.cn/f/d21fd08c90824241a9b8/?dl=1)
"""

# ╔═╡ a921b1f0-f6a0-4829-9ba3-0f4f999bfef5
md"""## 1.3 地球基本结构： 观测
$\Large\color{red}地球内部结构\leftrightarrows地球物理场$
* 温度、压力 $\Rightarrow$ 矿物组分 $\Rightarrow$ 密度、速度、磁性、电性、导热... 
* 地球磁场总强度
![](https://box.nju.edu.cn/f/27558433d0cf45d283f3/?dl=1)

"""

# ╔═╡ 169cf708-aaf6-43f7-8539-a142157c13a9
md"""## 1.3 地球基本结构： 模型
$\Large\color{red}地球内部结构\leftrightarrows地球物理场$
!!! tip "温度、压力 ==> 矿物组分 ==> 密度、速度、磁性、电性、导热... "
"""

# ╔═╡ 56c712d1-b290-46fd-85f6-69c9a700aa26
TwoColumn(md"""
!!! note "地球内部的温度"
	- 地壳： 15～30°C/km，底部达 1000°C
	- 地幔： 梯度较小，底部达 3000°C
	- 地核： 增加缓慢，地心达 5200°C
""",md"""
!!! note "地球内部的压力"
	- 地壳： 线性增加，底部达 1 Gpa
	- 地幔： 线性增加，底部达 136 Gpa
	- 地核： 外核底 329 Gpa，地心 364 Gpa

"""

	
)

# ╔═╡ 4454a20f-f267-4fb2-b4d1-42d87cd4afe6
md"""
![](https://box.nju.edu.cn/f/4a4d75c3a08e4a188259/?dl=1)

$\Large\color{red}地球的一级结构： 圈层结构$
"""

# ╔═╡ 7587ffed-a4cd-4428-bef7-68cb27798fcc
html"""
<h2>1.3 地球基本结构： 模型</h2>
<center>
<img src="https://box.nju.edu.cn/f/b37a28fe41dc45a78568/?dl=1" height="300">
</center>
"""

# ╔═╡ cde08961-70cc-4c36-b6e3-9eb2e5bd67bc
TwoColumn(html"""
<p style="display: flex; flex-direction: column; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/74491c8be4664f2a8762/?dl=1" height="200" style="margin:auto">
</p>
"""
, md"""
| | 大洋地壳 | 大陆地壳 |
| :---: | :---: | :---: |
| 厚度 | 5-8 公里| 30-70 公里 |
| 成分 | 基性岩 | 上地壳中酸性/下地壳基性 | 
| 密度 | 2.9 $g/cm^3$  | 平均 2.7 $g/cm^3$ | 
| 年龄 | 小于2亿年 | 可达40亿年 |
"""	
)

# ╔═╡ bd11d9ba-f0f0-4cb7-8389-d5aaaf93eafc
html"""
<h2>1.3 地球基本结构： 模型</h2>
<p style="display: flex; flex-direction: column; justify-content: center; align-items: center; margin:auto">
<img src="https://box.nju.edu.cn/f/c109c76864e34a709641/?dl=1" height="280">
<img src="https://box.nju.edu.cn/f/73f2e684f2f64b7f8492/?dl=1" height="300">
</p>
"""

# ╔═╡ a87f917e-fbe3-4b41-8289-2b598cdab0cf
md"""## 1.3 地球基本结构： 小结
地球物理学通过对**不同尺度**的物理场观测和研究，提供了地球内部不同尺度的物质**结构、组成和状态**的信息
- 地球物理场的全球分布特征 $\Rightarrow$ 地球本体的基本结构
- 区域尺度的物理场变化 $\Rightarrow$ 地球内部普遍存在横向不均一性
- 中小尺度的局部异常 $\Rightarrow$ 各种中小尺度的地质现象和地质问题
"""

# ╔═╡ c3044716-af3f-4de6-b5dc-881487d36293
html"""
<p style="display: flex; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/9ee9df1c536c46ea949d/?dl=1" height="150" style="margin:auto">
<img src="https://box.nju.edu.cn/f/d407a196f1d548cdb910/?dl=1" height="140" style="margin:auto">
</p>
"""

# ╔═╡ 34e0ff14-d3bd-4df2-bdb7-984dd612a907
html"""
<center>
<img src="https://box.nju.edu.cn/f/533ade37e39c432c93e7/?dl=1" height="300">
</center>
"""

# ╔═╡ 2f55b0e2-4293-4ea2-ad90-b95726abe032
md"""
## 1.x 思考题
* 地球物理学与地理学、地质学、地球化学等学科有哪些区别、互补性？
* 你的家乡在哪里？有哪些地质问题或工程问题需要通过地球物理的方法解决？
* 从2024年的新闻报道中，查找与地球物理相关或者地球物理学能够解决问题的新闻。
"""

# ╔═╡ Cell order:
# ╟─57b08715-dda4-46f7-bb5a-f868491be8eb
# ╠═7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
# ╟─5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
# ╟─232c59fa-77b2-470c-ae85-fa8e8b14c301
# ╟─aaa0f3cc-f507-4f12-a611-0560fe8ecb24
# ╟─818bbfd3-181a-49fa-8e11-e61fc921cee8
# ╟─400ae1f1-4ee9-4f48-9fda-1f46918c452c
# ╟─c663c599-239d-4e5a-9d4b-2337eda0d6ba
# ╟─6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
# ╟─69d6d08f-b03f-4975-9974-6daacbf2576f
# ╟─08282040-eefc-4d50-b842-f2117e071f49
# ╟─a94a1f96-59ea-4447-a9e6-d3012549259c
# ╟─205a4f51-11c1-4b5e-8cf2-049cefe8c702
# ╟─007546fe-f8aa-45b1-b46f-7b5fcf70749c
# ╟─eaa37388-46e0-41aa-9587-30ea849eaeca
# ╟─a5275d80-81a0-44bb-87ea-10e0ae1dd7bd
# ╟─99932797-1e49-4233-9c02-8f8524233a7e
# ╟─1ad4d977-ed65-4170-a175-927efc57b18b
# ╟─fbcfaf3a-4497-4274-a162-4b6a05bda333
# ╟─c9f377ff-15e7-4414-ae88-b531fba2c947
# ╟─350c6713-c16a-4888-850c-281dcc03837a
# ╟─54bab2e3-c118-4833-9354-0ac1fafde563
# ╟─2bd81ac7-e680-4e18-a830-cf5d4e99d914
# ╟─0fd05b4a-7721-43df-89c6-d84e9e302858
# ╟─eb0b78f3-3dbc-4d8c-9099-c87b6238f30d
# ╟─6470342a-66a9-4b3b-96e8-becab3f727ee
# ╟─cc4d17e0-c839-4430-84fc-76860c67d434
# ╟─9d737090-1290-488a-8e59-b50f4222658c
# ╟─22e278e6-b66e-4dff-9710-b9297540f7a9
# ╟─6b7c9cbb-36f8-4f73-8cf9-d6a876f1145d
# ╟─09ca25f6-5239-466c-88ce-b79bb65c9444
# ╟─821ea226-1fc8-4410-a53a-447114d87bd4
# ╟─48eb1246-c087-4801-9a46-35b2a9ce74fb
# ╟─7ff8a6cb-5e96-4b0b-8dcd-69c4e733ac53
# ╟─78e2ff57-7dcd-4256-aec8-31c8e58027d0
# ╟─3e4612c4-9c31-4f2f-90b4-e177348dd9d8
# ╟─764a44e8-6536-458e-aeb8-1e1a5ea12b47
# ╟─a921b1f0-f6a0-4829-9ba3-0f4f999bfef5
# ╟─169cf708-aaf6-43f7-8539-a142157c13a9
# ╟─56c712d1-b290-46fd-85f6-69c9a700aa26
# ╟─4454a20f-f267-4fb2-b4d1-42d87cd4afe6
# ╟─7587ffed-a4cd-4428-bef7-68cb27798fcc
# ╟─cde08961-70cc-4c36-b6e3-9eb2e5bd67bc
# ╟─bd11d9ba-f0f0-4cb7-8389-d5aaaf93eafc
# ╟─a87f917e-fbe3-4b41-8289-2b598cdab0cf
# ╟─c3044716-af3f-4de6-b5dc-881487d36293
# ╟─34e0ff14-d3bd-4df2-bdb7-984dd612a907
# ╟─2f55b0e2-4293-4ea2-ad90-b95726abe032
