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
# Lecture 7: 折射波探测方法

!!! note "提纲"
	1. 多层介质折射波
	2. 倾斜界面折射波
	3. 起伏界面折射波
	4. 远震折射波方法

"""

# ╔═╡ 924e1be8-7d2d-47bf-9f1a-bf69f73b8401
md"""
## 7.1 多层介质折射波
"""

# ╔═╡ 5419d16f-6146-4148-b7d8-85f77ac00829
TwoColumn(0.6,"center","start",
md"""
![](https://box.nju.edu.cn/f/b6eeec31030f4ac1b033/?dl=1)
""",
md"""
!!! tip "天然地震折射波"
	* 入射角达到临界角： $\sin\theta_0=v_1/v_2$


$$t=\frac{\Delta}{v_2}+\frac{(2H-h)\cos\theta_0}{v_1}$$

!!! note "曲线特点"
	* 走时方程为直线
	* 斜率$t=1/v_2$ 
	*  $t$ 轴截距为$t_0=(2H-h)\cos\theta_0/v_1$
"""
	
)


# ╔═╡ 2c9cc62e-b728-46e1-a9e2-a9bec829f814
TwoColumn(0.6,"center","start",
md"""
![](https://box.nju.edu.cn/f/9049843bcedb45a2a068/?dl=1)
""",
md"""
!!! tip "人工地震折射波"
	* 入射角达到临界角： $\sin\alpha=v_1/v_2$
	*  $\cos\alpha=\sqrt{v_2^2-v_1^2}/v_2$


$$t=\frac{x}{v_2}+\frac{2h\cos\alpha}{v_1}$$

!!! note "曲线特点"
	* 走时方程为直线
	* 斜率$t=1/v_2$ 
	*  $t$ 轴截距为$t_0=2h\cos\alpha/v_1$
"""
	
)


# ╔═╡ 0903dc22-f03e-4759-acf9-21fdde0d7718
md"""
### 双层水平介质
"""

# ╔═╡ 6a8e7814-1f8d-421e-9b03-233fe0b5df4a
TwoColumn(0.5,"start","start",
md"""

![](https://box.nju.edu.cn/f/cc196b793dbd4b95ad8f/?dl=1)
""",
md"""
$$t=\frac{x}{v_3}+\frac{2h_1\cos\alpha_{13}}{v_1}+\frac{2h_2\cos\alpha_{23}}{v_2}$$

其中：

$$\sin\alpha_{13}=v_1/v_3, \cos\alpha_{13}=\sqrt{1-v_1^2/v_3^2}$$


$$\sin\alpha_{23}=v_2/v_3, \cos\alpha_{23}=\sqrt{1-v_2^2/v_3^2}$$


!!! note "曲线特点"
	* 走时方程为直线
	* 斜率$t=1/v_3$ 
	*  $t$ 轴截距为$t_0=2h_1\cos\alpha_{13}/v_1+2h_2\cos\alpha_{23}/v_2$
	
"""
	
)


# ╔═╡ 81b774d9-08bc-4f61-be41-d0f3f3ecd9d9
md"""
### 多层水平介质
* 速度为$v_1, v_2, v_3, ..., v_n$
* 厚度为$h_1, h_2, h_3, ..., h_n$

$$t_n=\frac{x}{v_n}+\sum_{i=1}^{n-1}\frac{2h_i\cos\alpha_{in}}{v_i}=\frac{x}{v_n}+2\sum_{i=1}^{n-1}h_i/\frac{v_iv_n}{\sqrt{v_n^2-v_i^2}}$$

其中：

$$\alpha_{in}=sin^{-1}(v_i/v_n)$$

!!! note "穿透速度"
	*  ${v_iv_n}/{\sqrt{v_n^2-v_i^2}}$为穿透速度
	* 等效传播： 垂直向下入射$\Rightarrow$水平传播$\Rightarrow$垂直向上入射
"""

# ╔═╡ aa7aee3e-22d7-4eda-960a-f02a644d5389
md"""
## 7.2 倾斜界面折射波
"""

# ╔═╡ 220ab05d-3e69-4e02-8468-87793fdef5ee
TwoColumn(0.6,"start","start",
md"""
![](https://box.nju.edu.cn/f/33d3f6d3c5be415a8a4f/?dl=1)

""",md"""
下倾方向：

$$t_d=\frac{x\sin(\alpha+\varphi)}{v_1}+\frac{2h_d\cos\alpha}{v_1}$$

* 视速度： $v_d^*=v_1/\sin(\alpha+\varphi)$

* 截距为： $t_{0d}=2h_d\cos\alpha/v_1$

上倾方向：

$$t_u=\frac{x\sin(\alpha-\varphi)}{v_1}+\frac{2h_u\cos\alpha}{v_1}$$

* 视速度： $v_u^*=v_1/\sin(\alpha-\varphi)$

* 截距为： $t_{0u}=2h_u\cos\alpha/v_1$

""")

# ╔═╡ 9cd6e34f-2315-4853-9934-e10decd44ceb
Foldable("How to get?",
md"""
$$t_d=\frac{h_d/\cos\alpha}{v_1}+\frac{h_u/\cos\alpha}{v_1}+\frac{x\cos\varphi-h_d\tan\alpha-h_u\tan\alpha}{v_2}$$

$$t_d=\frac{h_d}{v_1 \cos\alpha}+\frac{h_d+x\sin\varphi}{v_1 \cos\alpha}+\frac{x\cos\varphi-2h_d\tan\alpha-x\sin\varphi\tan\alpha}{v_2}$$

$$t_d=\frac{x\sin(\alpha+\varphi)}{v_1}+\frac{2h_d\cos\alpha}{v_1}$$

"""
)

# ╔═╡ 2a911f14-807a-49b6-abb3-f7366f0e60e5
md"""
!!! note "倾斜界面折射波走时曲线"
	* 走时曲线都是直线
	* 与时间轴截距较大的为下倾方向
	* 视速度更小的为下倾方向
"""

# ╔═╡ dfcbd911-f1ba-46d9-9f9f-b289d0e892f0
md"""
### 求解倾斜界面的倾角$\varphi$

$$\alpha=\frac{1}{2}\left[ \sin^{-1}\frac{v_1}{v_d^*} + \sin^{-1}\frac{v_1}{v_u^*} \right]$$


$$\varphi=\frac{1}{2}\left[ \sin^{-1}\frac{v_1}{v_d^*} - \sin^{-1}\frac{v_1}{v_u^*} \right]$$

"""

# ╔═╡ b597ca02-b6f6-4cf9-b7c1-7dea9d6f2cfc
md"""
### 求解下层介质的速度$v_2$

$$\left| \frac{1}{v_u^*} \right| + \left| \frac{1}{v_d^*} \right| = \frac{2\sin\alpha\cos\varphi}{v_1} = \frac{2\cos\varphi}{v_2}$$

当$\varphi$比较小时（$<10^\circ \sim 15^\circ$），$\cos\varphi\approx1$：

$$v_2\approx\frac{2}{k_{2u}+k_{2d}}$$

### 求解倾斜界面的垂直深度

进一步地：

$$h_d=\frac{v_1 t_{0d}}{2\cos\alpha}$$

$$h_u=\frac{v_1 t_{0u}}{2\cos\alpha}$$

"""

# ╔═╡ 111b33ac-fce6-4ab0-a756-f53b9aa9e9ff
md"""
### 一些特例
"""

# ╔═╡ a1c82d8f-012f-4b59-ac51-7f5679eb0ce0
TwoColumn(1/2,"start","start",
md"""
![](https://box.nju.edu.cn/f/006403a25a1b4970aa54/?dl=1)
""",md"""
---
下倾方向： $t_d=\frac{x\sin(\alpha+\varphi)}{v_1}+\frac{2h_d\cos\alpha}{v_1}$

上倾方向： $t_u=\frac{x\sin(\alpha-\varphi)}{v_1}+\frac{2h_u\cos\alpha}{v_1}$

$~$

#### $\alpha+\varphi>90^\circ$
* 下倾方向观测不到折射波
* 上倾方向无法形成折射波

""")

# ╔═╡ ab5745b6-d799-4730-8abf-be5e5545b1ad
TwoColumn(1/2,"start","start",
md"""
![](https://box.nju.edu.cn/f/58ffc58c12e74f3cad4a/?dl=1)
""",md"""
---
下倾方向： $t_d=\frac{x\sin(\alpha+\varphi)}{v_1}+\frac{2h_d\cos\alpha}{v_1}$

上倾方向： $t_u=\frac{x\sin(\alpha-\varphi)}{v_1}+\frac{2h_u\cos\alpha}{v_1}$

$~$

#### $\alpha=\varphi$
*  $v_u^*=+\infty$
* 所有震中距地震波同时到达

""")

# ╔═╡ 61c52334-873a-4683-99d9-720a3cfb170e
TwoColumn(1/2,"start","start",
md"""
![](https://box.nju.edu.cn/f/c3972ee193624c4f8184/?dl=1)
""",md"""
---
下倾方向： $t_d=\frac{x\sin(\alpha+\varphi)}{v_1}+\frac{2h_d\cos\alpha}{v_1}$

上倾方向： $t_u=\frac{x\sin(\alpha-\varphi)}{v_1}+\frac{2h_u\cos\alpha}{v_1}$

$~$

#### $\alpha<\varphi$
*  $v_u^*<0$
* 震中距大的地方地震波先到达

""")

# ╔═╡ 8b9a3fe1-cefa-4b1a-9ef8-d1e72cefbe0d
TwoColumn(1/2,"start","start",
md"""
#### 低速层的屏蔽效应
![](https://box.nju.edu.cn/f/74b2fc6efb034b01a40f/?dl=1)
""",md"""
#### 无法探测高速薄层
![](https://box.nju.edu.cn/f/f8f86717d54b41cb8c3e/?dl=1)
""")

# ╔═╡ 31887cb7-e3ba-4950-953d-4b04d0d0773a
md"""
![](https://box.nju.edu.cn/f/758376c9ac6e40f49122/?dl=1)
"""

# ╔═╡ 2fa3389c-dd7a-45d6-aca7-3d6029afe774
md"""
## 7.3 起伏界面折射波
"""

# ╔═╡ efab90a4-f9d5-4403-beac-9dec656688b9
TwoColumn(0.6,"center","start",
md"""
### 差数时距曲线法
![](https://box.nju.edu.cn/f/6343f0e8b306474986d3/?dl=1)
""",md"""

$$t_1=\frac{O_1A+BS}{v_1}+\frac{AB}{v_2}$$

$$t_2=\frac{O_2D+CS}{v_1}+\frac{CD}{v_2}$$

互换时间$T$为：

$$T=\frac{O_1A+O_2D}{v_1} + \frac{AB+BC+CD}{v_2}$$

折射界面曲率半径远大于埋深时，$\triangle SBC$为等腰三解形:

$$\frac{BS}{v_1}\approx\frac{CS}{v_1}=\frac{h}{v_1\cos\alpha}$$


$$\frac{BC}{v_2}\approx\frac{2h\tan\alpha}{v_2}$$



""")

# ╔═╡ 49e4986a-14e6-4873-afeb-2a13df5fb8c6
md"""
令：

$$t_0=t_1+t_2-T=\frac{BS}{v_1}+\frac{CS}{v_1}-\frac{BC}{v_2}=\frac{2h\cos\alpha}{v_1}$$

$${\color{red} h}=\frac{v_1 t_0}{2\cos\alpha}=(t_1+t_2-T)\frac{v_1}{2\cos\alpha}=K\cdot t_0$$

其中，

$$K=\frac{v_1}{2\cos\alpha}=\frac{1}{2\sqrt{\frac{1}{v_1^2}-\frac{1}{v_2^2}}}$$

因此，该方法的关键是求取$K$值，因此，需要知道$v_1$和$v_2$的值。
"""

# ╔═╡ dbf6343d-aaf2-43e2-aa18-1a7566dd0fb0
TwoColumn(0.6,"center","start",
md"""

![](https://box.nju.edu.cn/f/6343f0e8b306474986d3/?dl=1)
""",md"""
---
定义：

$$\Delta t(x)=T-t_2(x)$$

$$t_0(x) = t_1(x)+t_2(x)-T=t_1(x)-\Delta t(x)$$


$$\theta(x) = t_1(x)-t_2(x)+T=t_1(x)+\Delta t(x)$$

当界面起伏比较和缓时，

$$\frac{\delta\theta(x)}{\delta x}=\frac{\delta t_1(x)}{\delta x}-\frac{\delta t_2(x)}{\delta x}=\frac{1}{v_d^*}+\frac{1}{v_u^*}=\frac{2\cos\varphi}{v_2}$$

当$\varphi<15^\circ$时，$cos\varphi\approx 1$，

$\color{red} v_2\approx 2/\frac{\Delta\theta}{\Delta x}$

""")

# ╔═╡ a20d2b55-7a19-4652-a683-cb0eee183a8d
md"""
## 7.4 远震折射波方法
### 接收函数方法: $y=f(x)$
"""

# ╔═╡ f37665ad-ef94-4df2-8799-9eb1d2eeafd0
TwoColumn(1/2,"start","start",
md"""
![](https://box.nju.edu.cn/f/b88210826dce4075b3f3/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/c9a19494bf1842b2881b/?dl=1)
""")

# ╔═╡ 78c8229d-6693-40c8-9276-4c2c9ba201a8
md"""
### 接收函数实例： 龙门山
![](https://box.nju.edu.cn/f/14244108888847ad8722/?dl=1)

### 接收函数实例： 俯冲带
![](https://box.nju.edu.cn/f/3c662ac707af4096912c/?dl=1)

### 接收函数实例： 地幔转换带
![](https://box.nju.edu.cn/f/0f2b61615c4344289ff3/?dl=1)

### 接收函数实例： 青藏高原岩石圈
![](https://box.nju.edu.cn/f/40d2c3e1b2e34dc6a30b/?dl=1)
"""

# ╔═╡ 219120ba-3d12-48ad-97b8-a30313a06ce1
md"""
## 7.x 思考题
* 什么是穿透速度？ 如何利用穿透速度理解多层水平介质折射波的走时方程？
* 与反射波相比，人工地震折射波有哪些优、缺点？
* 如何理解俯冲带洋壳脱水过程与折射波之间的关系？
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
# ╟─924e1be8-7d2d-47bf-9f1a-bf69f73b8401
# ╟─5419d16f-6146-4148-b7d8-85f77ac00829
# ╟─2c9cc62e-b728-46e1-a9e2-a9bec829f814
# ╟─0903dc22-f03e-4759-acf9-21fdde0d7718
# ╟─6a8e7814-1f8d-421e-9b03-233fe0b5df4a
# ╟─81b774d9-08bc-4f61-be41-d0f3f3ecd9d9
# ╟─aa7aee3e-22d7-4eda-960a-f02a644d5389
# ╟─220ab05d-3e69-4e02-8468-87793fdef5ee
# ╟─9cd6e34f-2315-4853-9934-e10decd44ceb
# ╟─2a911f14-807a-49b6-abb3-f7366f0e60e5
# ╟─dfcbd911-f1ba-46d9-9f9f-b289d0e892f0
# ╟─b597ca02-b6f6-4cf9-b7c1-7dea9d6f2cfc
# ╟─111b33ac-fce6-4ab0-a756-f53b9aa9e9ff
# ╟─a1c82d8f-012f-4b59-ac51-7f5679eb0ce0
# ╟─ab5745b6-d799-4730-8abf-be5e5545b1ad
# ╟─61c52334-873a-4683-99d9-720a3cfb170e
# ╟─8b9a3fe1-cefa-4b1a-9ef8-d1e72cefbe0d
# ╟─31887cb7-e3ba-4950-953d-4b04d0d0773a
# ╟─2fa3389c-dd7a-45d6-aca7-3d6029afe774
# ╟─efab90a4-f9d5-4403-beac-9dec656688b9
# ╟─49e4986a-14e6-4873-afeb-2a13df5fb8c6
# ╟─dbf6343d-aaf2-43e2-aa18-1a7566dd0fb0
# ╟─a20d2b55-7a19-4652-a683-cb0eee183a8d
# ╟─f37665ad-ef94-4df2-8799-9eb1d2eeafd0
# ╟─78c8229d-6693-40c8-9276-4c2c9ba201a8
# ╟─219120ba-3d12-48ad-97b8-a30313a06ce1
# ╟─757c3003-384b-4aee-8624-c59268d82b51
# ╟─236a9a53-03f4-4eb1-babd-5d1c4919a569
