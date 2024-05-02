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

# ╔═╡ 3d4bfe36-bd67-4841-aaee-13c4537ef464
md"""
# Lecture 6: 反射波探测方法

!!! note "提纲"
	* 单层介质反射波
	* 多层介质反射波
	* 倾斜界面反射波
	* 共反射点叠加
	* 速度谱与速度分析
	* 地震剖面解释
	* 天然地震反射波方法

"""

# ╔═╡ a20d2b55-7a19-4652-a683-cb0eee183a8d
md"""
## 6.1 单层介质反射波
"""

# ╔═╡ d532b886-2494-48c8-bd8c-3bb8e7ffe3f7
TwoColumn(1/2,"center","start",
md"""
![](https://box.nju.edu.cn/f/4b7ad39f95154262a99e/?dl=1)
""",
md"""
!!! tip "反射波"

$$t=\frac{\sqrt{x^2+4h^2}}{v}$$

回声时间（$x=0$时）：

$$t_0=2h/v$$

因此：

$$t^2=t_0^2+\frac{x^2}{v^2}$$

"""
	
)

# ╔═╡ be7c084d-7a7b-44f6-9ca9-f6dea10b7293
TwoColumn(0.4,"start","start",
md"""
### 确定层速度
---
$$t^2=t_0^2+\frac{x^2}{v^2}$$

#### 1: $t^2-x^2$方法

* 制作$t^2-x^2$曲线
* 其为直线，斜率为$1/v^2$
* 时间轴上的截距为$t_0^2={4h^2}/{v^2}$

""",md"""
#### 2: 泰勒展开

$$t=t_0 \left[ 1+(\frac{x}{vt_0})^2 \right]^{1/2}$$

$$t=t_0 \left[ 1 + \frac{1}{2}(\frac{x}{vt_0})^2 - \frac{1}{8}(\frac{x}{vt_0})^4 + ... \right]^{1/2}$$

其中$x/vt_0=x/2h$，当$\color{red}2h \gg x$时，

$$t \approx t_0 + \frac{x^2}{2v^2t_0}$$


!!! tip "正常时差"
	炮检距$x$处的正常时差: $\Delta t = t_x - t_0 = x^2/2v^2t_0$

因此，$v=x/(2t_0\Delta t)^{1/2}$

""")

# ╔═╡ 273afad0-09f6-4bdf-9c57-ec387b3d9450
md"""
## 6.2 多层介质反射波
"""

# ╔═╡ 85f412b7-6ab4-4b93-be84-9fdac7327959
TwoColumn(4/7,"start","start",
md"""
![](https://box.nju.edu.cn/f/6e5ecf3de28f40439ca2/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/c0f40229f2354f9aa638/?dl=1)


""")

# ╔═╡ d8e62c9e-58f6-4e39-a370-eef75d35a8b1
TwoColumn(1/2,"start","center",
md"""
$$t^2=t_0^2+\frac{x^2}{v_{rms}^2}$$

其中：

$$t_0=\frac{2H}{v_{rms}}\approx \sum_{i=1}^{n}\frac{2h_i}{v_i}$$


$$v_{rms,n}=\left[ \frac{\sum_{i=1}^{n}{v_i^2t_i}}{\sum_{i=1}^{n}t_i} \right]^{1/2}$$
""",md"""
#### Dix公式与速度反演

$$v_{i}=\left[ \frac{v_{rms}^2t_i-v_{rms,i-1}^2t_{i-1}}{t_i-t_{i-1}}  \right]^{1/2}$$

""")

# ╔═╡ c086520c-84aa-4e84-a29a-e7e84b44bd88
md"""
## 6.3 倾斜界面反射波
"""

# ╔═╡ b21af9b2-212e-495d-97f8-60bccdb278bc
TwoColumn(1/2,"start","start",
md"""
![](https://box.nju.edu.cn/f/2514f5917e2049ab85f6/?dl=1)
""",md"""
 $O$点的对称点$O^*$的坐标为：

$$x_m=-2h\sin\varphi$$

$$z_m=2h\cos\varphi$$

 $x$处的反射波走时$t$可表示为：

$$t=\frac{O^*S}{v}=\frac{[(x-x_m)^2+z_m^2]^{1/2}}{v}$$

$$t=\frac{(x^2+4h^2+4xh\sin\varphi)^{1/2}}{v}$$

$$t\approx t_0+\frac{x^2+4xh\sin\varphi}{2v^2t_0}$$

 $t_0=2h/v$为地震波垂直反射的双程走时。

""")

# ╔═╡ 7b9a6add-71d5-4cc3-98b3-1270fc578e3c
md"""
由于双曲线关于时间轴不对称，其在$x$和$-x$点的传播时间$t_x$和$t_{-x}$不同：

$$\Delta t_d = t_x - t_{-x} = 2xh\sin\varphi/v$$

因此， 倾角$\varphi$比较小时， $\sin\varphi \approx \varphi$，

$$\varphi \approx \sin\varphi = v\Delta t_d/2x$$

"""

# ╔═╡ 042f7d9e-2e0f-4bf9-b06f-c44c235b655d
md"""
## 6.4 共反射点叠加
"""

# ╔═╡ 94596d47-00e9-464f-9cf2-a6404a40a1e1
TwoColumn(0.6,"start","start",
md"""
![](https://box.nju.edu.cn/f/979544e2f2c24d359534/?dl=1)
""",md"""
#### 共反射点/深度点叠加
* Common depth point (CDP)
* Common midpoint (CMP)
* 反射波不是初至波，受干扰
* 近垂直入射时的反射系数低
* 通过信号叠加，增强反射信号
* 通过多次覆盖叠加技术实现

""")

# ╔═╡ 29aabafc-4c4f-4326-a28b-877fb9123c74
TwoColumn(0.7,"start","start",
md"""
![](https://box.nju.edu.cn/f/5f30b83c66624eccaff7/?dl=1)
""",md"""
#### 共反射点道集
* M点为共中心点
* A点为共反射点
* 经过A点反射的各接收道称共反射点道/共中心点道

#### 走时方程

$$t_i=\sqrt{x_i^2+4h^2}/v$$

 $t_0=2h/v$称为回声时间

### 动校正
校正理论（正常）时差 $\color{red}\Delta t_i$

$$\Delta t_i=t_i-t_0=\frac{x_i^2+4h^2}{v}-\frac{2h}{v}$$

$$\Delta t_i=t_0(\sqrt{1+(\frac{x_i}{2h})^2}-1)$$

当 $x_i/2h\ll1$时

$$\Delta t_i\approx\frac{t_0}{2}(\frac{x_i}{2h})^2=\frac{x_i^2}{2v^2t_0}$$

""")

# ╔═╡ eb2511a6-e93e-430d-a83c-3475ee68aeda
TwoColumn(1/2,"center","center",
md"""
!!! tip "静校正"
![](https://box.nju.edu.cn/f/db9a324476504695b86f/?dl=1)
""",md"""
---
#### 校正地形及近地表速度影响
![](https://box.nju.edu.cn/f/1478c27127274152abb3/?dl=1)
""")

# ╔═╡ 5fc439ce-7d53-4c2f-924d-fbdbb31be3ca
md"""
## 6.5 速度谱与速度分析
"""

# ╔═╡ 1d68eee2-e6a8-46de-b4cc-394366af1430
TwoColumn(0.6,"start","start",
md"""
![](https://box.nju.edu.cn/f/979544e2f2c24d359534/?dl=1)
""",md"""
* 地下可以分多少层？
* 各层的速度/厚度是多少？

""")

# ╔═╡ 912e94f4-0c5c-48ac-99b9-3c5d24307990
md"""
#### 问题简化： 层状结构假定
![](https://box.nju.edu.cn/f/7f040fd392eb40fabe00/?dl=1)
"""

# ╔═╡ a01aa000-96f4-4a1e-9415-9693669ffa4a
md"""
#### 均方根速度校正
![](https://box.nju.edu.cn/f/669b7da583f946568648/?dl=1)
"""

# ╔═╡ 899f7ce5-2759-45a3-9630-b9c224723330
md"""
#### 横向叠加
* 一致的信号增强
* 不一致的信号抵消
![](https://box.nju.edu.cn/f/3234e7fb3e60499eacd7/?dl=1)
"""

# ╔═╡ 81ad87be-1bb3-42fc-a704-298fdeb24daf
md"""
### 速度谱分析
![](https://box.nju.edu.cn/f/01b3b217445a4eb3a473/?dl=1)
"""

# ╔═╡ de848507-a2bd-4347-8ca2-2a8a6eab94f7
md"""
#### 层状结构构建
![](https://box.nju.edu.cn/f/460233398b92496c960f/?dl=1)

"""

# ╔═╡ db225bd5-3ec4-4f34-a008-63292384b658
TwoColumn(0.7,"start","center",
md"""
![](https://box.nju.edu.cn/f/93cca220df4542778591/?dl=1)
""",md"""

#### Dix公式与速度反演： $$v_{i}=\left[ \frac{v_{rms}^2t_i-v_{rms,i-1}^2t_{i-1}}{t_i-t_{i-1}}  \right]^{1/2}$$
""")

# ╔═╡ d834275b-1fbe-4e34-85dd-a987cad83751
md"""
## 6.6 地震剖面解释
!!! note "地震时间剖面"
	* 纵轴是双程反射时间$t_0$
	* 横轴为剖面的空间距离, 在每个共中心点(CMP)位置上

![](https://box.nju.edu.cn/f/f515b3abd3534f22a66f/?dl=1)
"""

# ╔═╡ 593700cf-b8aa-48cf-9edc-794dad26d240
md"""
!!! note "反射波识别与追踪基本原则"
	* 强振幅： 当反射波出现时，振幅明显增强
	* 同相性： 来自同一界面的反射波，在相邻地震记录上反射时间相近、相位一致
	* 波形相似： 相邻地震道上波形特征一致是同一界面反射波组的标志

!!! note "地震剖面解释"
	* **反射层位标定**： 分布范围广且稳定、标志突出、地质层位明确， 代表测区内构造格局的基本特征
	* **断层解释**： 同相轴错断， 断层两侧波组关系稳定； 同相轴突然增减或消失、波组间隔突然变化
	* **不整合面**： 不整合面往往是侵蚀面，地层间波阻抗变化大，振幅有较大变化
	* **地震构造图**： 将地震剖面上同一标识层的 $t_0$ 值投影到平面上，勾画出等 $t_0$ 值图

![](https://box.nju.edu.cn/f/d13a32a1c51b481e900a/?dl=1)
"""

# ╔═╡ 2a4ce82e-c5df-42d3-b30e-15856fe6822e
md"""
#### 深反射地震探测地壳上地幔结构
* 20 世纪 70 年代，以康奈尔大学为主的美国大学和壳牌石油公司的地球物理学家组成大陆反射剖面联合会(The Consortium for Continental Reflection Profiling, COCRP)，1972年开始试验在深部地震探测中应用多次覆盖观测系统，此后随着技术的不断进步，可以清晰接收到 50 km 深度的反射波。

* 中国最早开展的深地震探测是 1992~1994 年青藏高原与喜马拉雅深部剖面探测 (INDEPTH)计划，由中国、美国、德国、加拿大等多家国际学术组织共同合作完成， 此后又继续开展了 INDEPTH 二期(1995~1996 年)、三期(1998~2000 年)和四期 (2003~2006 年)项目。

!!! note "INDEPTH计划"	
	* 测线总长度约 400 km
	* 每 200米 设置一个 50 kg炸药的小当量爆破
	* 每3000米设置一个200 kg炸药的大当量爆破
	* 检波器间距 为 50 米 和 25 米两种
	* 地震记录时长 50 s， 经过 15 次叠加
![](https://box.nju.edu.cn/f/58b52cb3681f466e8f0a/?dl=1)

"""

# ╔═╡ b180cfbe-2413-484b-99f4-417fc9496dbe
md"""
## 6.7 天然地震反射波方法
#### 地幔转换带探测
![](https://box.nju.edu.cn/f/cfbbb06c2f1a4ac482f7/?dl=1)

![](https://box.nju.edu.cn/f/ce3c5a86cff64ce6ba67/?dl=1)

#### D"间断面探测
![](https://box.nju.edu.cn/f/42db427e2e09449c9a02/?dl=1)

![](https://box.nju.edu.cn/f/5b988ed39811413a9a38/?dl=1)
"""

# ╔═╡ 219120ba-3d12-48ad-97b8-a30313a06ce1
md"""
## 6.x 思考题
* 简述共反射点叠加方法的原理与过程。
* 简述利用反射波道集进行速度分析的方法。
* 阅读文献，查找地球有哪些速度间断面。
"""

# ╔═╡ 757c3003-384b-4aee-8624-c59268d82b51
html"""
<div style="background-color: orange; pandding: 10px;">
	<h1> End here! </h1>
	<span style="background-color: yellow;"> it has yellow backgounrd. </span>
</div>
"""

# ╔═╡ 236a9a53-03f4-4eb1-babd-5d1c4919a569
md"""
### 
| Column One | Column Two | Column Three |
|:---------- | ---------- |:------------:|
| Row `1`    | Column `2` |              |
| *Row* 2    | **Row** 2  | Column ``3`` |
"""

# ╔═╡ Cell order:
# ╟─7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
# ╟─5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
# ╟─aaa0f3cc-f507-4f12-a611-0560fe8ecb24
# ╟─400ae1f1-4ee9-4f48-9fda-1f46918c452c
# ╟─6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
# ╟─08282040-eefc-4d50-b842-f2117e071f49
# ╟─d242187f-6179-49d1-a32a-1c750e173005
# ╟─3d4bfe36-bd67-4841-aaee-13c4537ef464
# ╟─a20d2b55-7a19-4652-a683-cb0eee183a8d
# ╟─d532b886-2494-48c8-bd8c-3bb8e7ffe3f7
# ╟─be7c084d-7a7b-44f6-9ca9-f6dea10b7293
# ╟─273afad0-09f6-4bdf-9c57-ec387b3d9450
# ╟─85f412b7-6ab4-4b93-be84-9fdac7327959
# ╟─d8e62c9e-58f6-4e39-a370-eef75d35a8b1
# ╟─c086520c-84aa-4e84-a29a-e7e84b44bd88
# ╟─b21af9b2-212e-495d-97f8-60bccdb278bc
# ╟─7b9a6add-71d5-4cc3-98b3-1270fc578e3c
# ╟─042f7d9e-2e0f-4bf9-b06f-c44c235b655d
# ╟─94596d47-00e9-464f-9cf2-a6404a40a1e1
# ╟─29aabafc-4c4f-4326-a28b-877fb9123c74
# ╟─eb2511a6-e93e-430d-a83c-3475ee68aeda
# ╟─5fc439ce-7d53-4c2f-924d-fbdbb31be3ca
# ╟─1d68eee2-e6a8-46de-b4cc-394366af1430
# ╟─912e94f4-0c5c-48ac-99b9-3c5d24307990
# ╟─a01aa000-96f4-4a1e-9415-9693669ffa4a
# ╟─899f7ce5-2759-45a3-9630-b9c224723330
# ╟─81ad87be-1bb3-42fc-a704-298fdeb24daf
# ╟─de848507-a2bd-4347-8ca2-2a8a6eab94f7
# ╟─db225bd5-3ec4-4f34-a008-63292384b658
# ╟─d834275b-1fbe-4e34-85dd-a987cad83751
# ╟─593700cf-b8aa-48cf-9edc-794dad26d240
# ╟─2a4ce82e-c5df-42d3-b30e-15856fe6822e
# ╟─b180cfbe-2413-484b-99f4-417fc9496dbe
# ╟─219120ba-3d12-48ad-97b8-a30313a06ce1
# ╟─757c3003-384b-4aee-8624-c59268d82b51
# ╟─236a9a53-03f4-4eb1-babd-5d1c4919a569
