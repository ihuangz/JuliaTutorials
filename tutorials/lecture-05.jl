### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
begin
	using Pkg
	Pkg.activate()
	using PlutoUI
	using Plots
	using HypertextLiteral
	using LaTeXStrings
end

# ╔═╡ 5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
PlutoUI.TableOfContents(title="目录",aside=true)

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

# ╔═╡ 400ae1f1-4ee9-4f48-9fda-1f46918c452c
begin
	struct TwoColumn{wid, centL, centR, L, R}
		width::wid
		centL::centL
		centR::centR
		left::L
	    right::R
	end
	function Base.show(io, mime::MIME"text/html", tc::TwoColumn)
		centerL="""align-self:"""*tc.centL*""";text-align:"""*tc.centL
		centerR="""align-self:"""*tc.centR*""";text-align:"""*tc.centR
		
	    write(io, """<div style="display: flex;gap:20px"><div style="flex: """)+write(io,string(tc.width*100))+write(io,"""%;""")+write(io,centerL)+write(io,""" ">""")
	    show(io, mime, tc.left)
	    write(io, """</div><div style="flex: """)+write(io,string(100.0-tc.width*100))+write(io,"""%;""")+write(io,centerR)+write(io,""" ">""")
	    show(io, mime, tc.right)
	    write(io, """</div></div>""")
	end
end

# ╔═╡ 6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]));

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



"""

# ╔═╡ d242187f-6179-49d1-a32a-1c750e173005
macro zsh_str(s) open(`zsh`,"w",stdout) do io; print(io, s); end; end

# ╔═╡ 149defda-28cb-48f1-a0e2-592b10128d4e
md"""
# Lecture 5: 地震观测系统

!!! note "提纲"
	* 地震仪
	* 天然地震观测
	* 人工地震观测

"""

# ╔═╡ c7eea271-ef58-43ff-a55d-a779f1bd8c97
md"""
## 5.1 地震仪
![](https://box.nju.edu.cn/f/187fca62de7c4dbf94cb/?dl=1)
* 地震仪是观测地震的设备，它测量地震引起的地面振动，并将其自动记录下来
* 现代地震仪是复杂而精密的设备，主要包括**拾震器**和**记录器**两大部分
!!! note "拾震器"
	* 拾震器的主要部分有拾取地面振动信号的“摆”
	* 将机械振动转换为电信号的传感器(或称为换能器)： 电动式、电容式、压电晶体式
	* 包括一个阻尼器，吸收仪器中“摆”的自由振荡能量，使“摆”尽快停止下来
!!! tip "放大器"
	* 为了检测微弱的地面振动信号，现代地震仪采用电子放大器来提高灵敏程度
!!! note "记录器"
	* 可直接显示的模拟记录： 将放大的地震信号直接显示在记录媒介上
	* 数值记录方式： 将放大的地震信号通过模-数转换，转换为数值信号进行存储
	* 当今地震观测均使用数字地震仪系统，不仅提高了地震记录的动态范围与分辨率， 也促进了地震学研究的数值计算与分析方法的发展
!!! tip "计时器"
	* 地震记录，要求精确测定地震波各个震相的到达时间，以及各震相的振幅和周期
	* 现今数字地震仪记录系统采用 GPS 时间同步，达到微秒级的稳定时间参考系，用于精确确定记录器的时间和地理位置
!!! note "三分量地震仪"
	* 地震仪的拾震器分垂向和水平向拾震器,分别记录垂直方向和水平方向的振动
	* 地震记录是三维空间中的振动特征，分别记录垂直、南北和东西方向的质点振动
	* 一台地震仪用一个垂直摆与两个水平摆构成三维正交系统，记录振动的空间变化
"""


# ╔═╡ 66dc5f24-6305-4c84-bf42-eef4e37b0113
md"""
#### 张衡侯风地动仪
![](https://box.nju.edu.cn/f/5212948dfc4e45869443/?dl=1)
"""

# ╔═╡ 6298dcbc-dc20-4dcf-9246-6d038af8da9c
md"""
#### 模拟地震记录系统
![](https://box.nju.edu.cn/f/2fd26bd0c162457d9d63/?dl=1)
"""

# ╔═╡ 9ff19e8e-2ad6-4644-8abe-9918d5863a38
TwoColumn(1/2,"start","center",
md"""
#### 第一个远震记录
* von Rebeur, 1889
![](https://box.nju.edu.cn/f/651c8b8f15ad45a095a2/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/a68dc29c8e814e159579/?dl=1)
""")

# ╔═╡ c82624fa-8af7-4676-a673-1bc953f62cb0
html"""
<h4> 现代地震计 </h4>
<img src="https://box.nju.edu.cn/f/0f3f750156224f5faa19/?dl=1" width=650 align="middle" >
<h4> 2023年山东平原5.5级地震记录 </h4>
<img src="https://box.nju.edu.cn/f/f66287c90dd24af386b8/?dl=1" width=650>
"""

# ╔═╡ cb5dc84c-78ea-4d06-86ba-113b516fc2b2
md"""
#### 三分量远震记录
![](https://box.nju.edu.cn/f/9c6f8c4aef3945b38ffc/?dl=1)
"""

# ╔═╡ f3f9646f-8834-4ed0-a7b8-7252dc085843
md"""
## 5.1 地震仪： 频带范围
#### 不同地震仪与震源的频带范围
![](https://box.nju.edu.cn/f/7a11022481ee4b8ab674/?dl=1)
* 地震波由不同周期成分的振动组成
* 不同的振动源产生的地震波有不同的周期范围
"""

# ╔═╡ 46dae62c-1640-44fa-8a37-2970fa588303
md"""
## 5.2 天然地震观测
"""

# ╔═╡ 5b411dcf-8136-421b-9201-7ddad31b9c21
TwoColumn(1/2,"start","start",
md"""
!!! note "固定地震台站观测"
	* 选址要求高
	* 要求记录环境的背景噪声极低
	* 观测记录是连续不间断的、长期的
	* 对地震记录进行实时监测分析
* 全球地震台网（GSN）
* 中国国家地震数字台网
* 日本Hinet和F-net地震台风
* 欧洲地震台网

""",md"""
!!! note "流动地震台站观测"
	* 兴起于20世纪70年代
	* 主要用于研究深部结构
	* 早期一般以垂直构造带的测线为主
	* 近年来，大规模流动台网兴起
	* 节点地震仪的新观测、研究范式
* USArray
* ChinArray
* AlpsArray
""")

# ╔═╡ ca2da160-6e31-4c16-9207-d13e90075356
md"""
#### 中国地震台网
"""

# ╔═╡ 68b7af18-f424-4aa5-b12e-1d366f99ba81
TwoColumn(1/2,"center","center",
md"""
![](https://box.nju.edu.cn/f/8dac58be1dcb4f9eaca2/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/6d0281eb57f14505a89d/?dl=1)
""")

# ╔═╡ 1521dc47-03f0-469d-a71f-a49d43e30b71
md"""
![](https://box.nju.edu.cn/f/a009670d1d0849b48e0d/?dl=1)
"""

# ╔═╡ cb4e7d5c-1b76-4817-91a1-4e2f0b34e41e
md"""
#### GSN全球台网的发展
![](https://box.nju.edu.cn/f/0f5b204e90674db0a940/?dl=1)
"""

# ╔═╡ 7be91f3a-d86e-44fa-80d3-1e6dc68436fc
md"""
#### 中国流动地震观测
* 跨越构造线
* 利用最小的代价获取结构的信息
![](https://box.nju.edu.cn/f/d8cd43e6a9d3475e8546/?dl=1)
#### 世界流动地震观测
![](https://box.nju.edu.cn/f/fe1bdb92c3f74637a333/?dl=1)
"""

# ╔═╡ d11dfaaf-d29a-460b-8e5d-22bfe0a62123
md"""
#### 节点式地震观测
* 利用空间换取时间
* 通过叠加增强信号
![](https://box.nju.edu.cn/f/ab18186c7cf0446caa8b/?dl=1)
(Johnson et al., 2020, JGR)


![](https://box.nju.edu.cn/f/043480477a0741d09d8d/?dl=1)
(Jin et al., 2023, CJG)


![](https://box.nju.edu.cn/f/5b86a04feab2450b9aa5/?dl=1)
(Wang et al., 2021, JGR)
"""

# ╔═╡ 2b18b716-f9a7-4c36-91eb-9a98044bd646
md"""
## 5.3 人工地震观测
!!! note "人工地震探测地下结构"
	* 地震能量不够强： 提高信噪比
	* 尽可能提高人工震源的利用效率
	* **更少的激发解决更多的问题**
![](https://box.nju.edu.cn/f/f50be2d734884cb09f27/?dl=1)
![](https://box.nju.edu.cn/f/e3d7caad8f5a47aca3a1/?dl=1)
"""

# ╔═╡ 60d9bb22-acfa-4aed-a962-a9ecd5bd8aa5
md"""
## 5.3 人工地震观测： 震源
!!! note "炸药震源"
	* 爆炸产生能量向外传播，最早使用
	* 优点： 良好的脉冲，能量集中，易调整
	* 缺点： 利用效率低，引起环境问题，人口密集地区严格控制
!!! note "落重法/机械撞击"
	* 重物冲击地面激发能量
	* 优点： 操作简单
	* 缺点： 能量较弱，仅适合小范围、浅地表探测
!!! note "可控震源"
	* 振动频率和延续时间都可以通过参数设置得以控制和改变
	* 优点： **频率可控**，探测效率高； 信号重复性好，适合叠加；破坏性小
	* 缺点： 能量比较弱
!!! note "气枪/气爆震源"
	* 高压气体快速释放形成震源
	* 优点： 重复性好、绿色环保、信号稳定；陆地上使用所爆震源；能量方向可控
	* 缺点： 能量比较弱
"""

# ╔═╡ 71624100-77ef-4002-92a0-1e56302f3b09
html"""
<h4>可控震源探测</h4>
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/cb01742fae1d41718ec3/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ 6a7004cb-1b4e-4a18-afca-d90a93ae7abf
html"""
<h4>海底地震探测</h4>
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/32dd982928da475eac41/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ dc9970fd-eb7a-48c7-ad0d-fa9661101f16
md"""
## 5.3 人工地震观测： 观测系统

#### 纵测线和非纵测线
* 炮点和检波点处在同一直线上称为纵测线: **常用**
* 炮点和检波点不在同一直线上称非纵测线
![](https://box.nju.edu.cn/f/7e9af844662d4d9f9a8c/?dl=1)

#### 单侧源发与两侧激发
![](https://box.nju.edu.cn/f/2a0a0496f8294ba8925f/?dl=1)

#### 观测系统基本原则
1. 排列的长度需考虑震源能量大小，应使最大炮检距处检波器收到有效信号;
2. 能获得探测目标(如反射界面或临界折射界面)的完整信息;
3. 道间距大小应 满足探测目标要求的分辨率。

"""

# ╔═╡ 2493114a-3d32-4f3d-834c-c4910393272a
md"""
## 5.3 人工地震观测：观测系统表示方法
为了获得完整的观测系统设计，便于勘探的实施，常用图示方法来直观地将设计的完整观测系统表示出来，常采用的图示方法有**时距平面法**和**综合平面法**。

#### 时距平面法
* 在横轴上标明激发点和接收段的位置，纵轴为时间
* 将激发至各检波器接收到信号的时间与炮检距关系(称时距曲线)大致画出来
![](https://box.nju.edu.cn/f/bfeee22a117c4fb4b8e3/?dl=1)

#### 综合剖面法
综合平面法更容易表示复杂的观测系统
* 横轴表示测线，并标明激发点和接收段的位置
* 从分布在测线上的各个激发点出发，向两侧作与测线呈 45°角的斜线坐标网
* 将测线上的有效接收排列投影在通过相应激发点的斜线上，用粗线或有色线标出
* 粗线或有色线向上的交点即是互换点

#### 反射地震多次覆盖观测系统
在反射地震勘探中，为了压制噪声与多次波信号干扰、提高地震记录的信噪比， 需要对反射信号进行多次叠加
* 有规律地同时移动激发点与接收排列, 对地下反射界面多次重复采样
* 在同一反射点采集多个反射信号，通过信号叠加提高信号质量

![](https://box.nju.edu.cn/f/9b04e9a7adf24b4c8dd7/?dl=1)
"""

# ╔═╡ 96718528-a59d-41fd-be50-2e0f11e9ea45
md"""
## 5.x 思考题
* 不同震相在三分量地震图上的分布有什么特点？
* 影响天然地震台站布设的因素有哪些？
* 人工震源选择需要考虑的主要因素有哪些？
"""

# ╔═╡ Cell order:
# ╟─7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
# ╟─5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
# ╟─aaa0f3cc-f507-4f12-a611-0560fe8ecb24
# ╟─400ae1f1-4ee9-4f48-9fda-1f46918c452c
# ╟─6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
# ╟─08282040-eefc-4d50-b842-f2117e071f49
# ╟─d242187f-6179-49d1-a32a-1c750e173005
# ╟─149defda-28cb-48f1-a0e2-592b10128d4e
# ╟─c7eea271-ef58-43ff-a55d-a779f1bd8c97
# ╟─66dc5f24-6305-4c84-bf42-eef4e37b0113
# ╟─6298dcbc-dc20-4dcf-9246-6d038af8da9c
# ╟─9ff19e8e-2ad6-4644-8abe-9918d5863a38
# ╟─c82624fa-8af7-4676-a673-1bc953f62cb0
# ╟─cb5dc84c-78ea-4d06-86ba-113b516fc2b2
# ╟─f3f9646f-8834-4ed0-a7b8-7252dc085843
# ╟─46dae62c-1640-44fa-8a37-2970fa588303
# ╟─5b411dcf-8136-421b-9201-7ddad31b9c21
# ╟─ca2da160-6e31-4c16-9207-d13e90075356
# ╟─68b7af18-f424-4aa5-b12e-1d366f99ba81
# ╟─1521dc47-03f0-469d-a71f-a49d43e30b71
# ╟─cb4e7d5c-1b76-4817-91a1-4e2f0b34e41e
# ╟─7be91f3a-d86e-44fa-80d3-1e6dc68436fc
# ╟─d11dfaaf-d29a-460b-8e5d-22bfe0a62123
# ╟─2b18b716-f9a7-4c36-91eb-9a98044bd646
# ╟─60d9bb22-acfa-4aed-a962-a9ecd5bd8aa5
# ╟─71624100-77ef-4002-92a0-1e56302f3b09
# ╟─6a7004cb-1b4e-4a18-afca-d90a93ae7abf
# ╟─dc9970fd-eb7a-48c7-ad0d-fa9661101f16
# ╟─2493114a-3d32-4f3d-834c-c4910393272a
# ╟─96718528-a59d-41fd-be50-2e0f11e9ea45
