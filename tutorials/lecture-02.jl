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
begin
	using Pkg
	Pkg.activate()
	using PlutoUI
	using Plots
	using HypertextLiteral
end

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

# ╔═╡ 5dd5c144-636f-4426-a41b-d09b7ef6932d
begin
	struct TwoColumn12{L, R}
	    left::L
	    right::R
	end
	function Base.show(io, mime::MIME"text/html", tc::TwoColumn12)
	    write(io, """<div style="display: flex;gap:20px"><div style="flex: 33.3%;">""")
	    show(io, mime, tc.left)
	    write(io, """</div><div style="flex: 66.6%;">""")
	    show(io, mime, tc.right)
	    write(io, """</div></div>""")
	end
end

# ╔═╡ a7af5c78-16c9-49f5-b2d1-216b564aefb1
begin
	struct TwoColumn21{L, R}
	    left::L
	    right::R
	end
	function Base.show(io, mime::MIME"text/html", tc::TwoColumn21)
	    write(io, """<div style="display: flex;gap:20px"><div style="flex: 66.6%;">""")
	    show(io, mime, tc.left)
	    write(io, """</div><div style="flex: 33.3%;">""")
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

# ╔═╡ ecec4a61-f93e-4358-bdb7-008cdf4dcdd1
md"""
# Lecture 2: 地震波的产生与传播
!!! note "提纲"
	* 震源的等效力学表示
	* 地震波在均匀介质中的传播： 波动方程
	* 地震波在速度间断面的反射与折射
 
"""

# ╔═╡ 8f3649f9-8a22-4838-927f-2ac7c1f7bc7e
md"""
## 2.1 震源的等效力学表示
!!! note "地震成因假说: 弹性回跳模型"
	* 地震发生前, 断层两侧的地块紧密结合在一起
	* 随着断层两侧产生相对运动, 断层附近的岩石发生形变, 积累应变能
	* 应力超过岩石破裂极限时, 岩石失稳, 破裂, 地震发生
	* 地震后, 应力恢复至新的平衡,进入下一个周期
![](https://box.nju.edu.cn/f/f06439cbaf6947cd9302/?dl=1)
"""

# ╔═╡ befe5e18-50a1-4b2c-83ef-7687d59c503d
md"""
## 2.1 震源的等效力学表示
!!! note "地震距张量"
	* 断层/震源定量描述: 等价力系$\Rightarrow$断层几何/滑动参数
	* 任何断层都表示为9个不同方向的力偶: 总体力矩平衡
$$\mathbf{M}=
\begin{bmatrix}
M_{xx} & M_{xy} & M_{xz}\\
M_{yx} & M_{yy} & M_{zy}\\
M_{zx} & M_{zy} & M_{zz}
\end{bmatrix}$$
 
![](https://box.nju.edu.cn/f/607c6916622c4c88a9a8/?dl=1)

!!! tip "复杂断层"
	将断层面划分为若干小块, 每人小块等效成一个点源, 每个点源产生的地震波线性叠加

"""

# ╔═╡ 81561842-82f9-4a36-9b72-595535e20f3c
md"""
## 2.2 地震波的传播： 波动方程
![](https://box.nju.edu.cn/f/4caf035cf3434bb88910/?dl=1)


"""

# ╔═╡ b542a667-4c43-41f6-89ee-129da08bc401
md"""

## 2.2 地震波的传播： P波波动方程
![](https://box.nju.edu.cn/f/3b745f07aff64a1985ae/?dl=1)

!!! tip "条件"
	* 均匀弹性杆, 密度为$\sigma$, 截面积为$S$
	* 选取$x\rightarrow x+dx$单元, 受力分别为$\tau(x)$和$\tau(x+dx)$, 位移分别为$u$和$u+du$
	* 对该质点, 采用牛顿第二定律:$\mathbf{F}=m\mathbf{a}$
$$[\tau(x+dx)-\tau(x)]\cdot S=(\sigma Sdx)\cdot \frac{\partial^2u(x,t)}{\partial t^2}$$
$$\frac{\partial\tau(x,t)}{\partial x}\cdot dx \cdot S = (\sigma Sdx)\cdot \frac{\partial^2u(x,t)}{\partial t^2}$$

!!! tip "弹性介质的胡克定律"
	$\tau(x,t)=E\frac{\partial u(x,t)}{\partial x}$

因此,可以得到一维均匀弹性杆的波动方程:

$$\frac{\partial^2u}{\partial t^2}=\frac{E}{\sigma}\cdot \frac{\partial^2u}{\partial x^2}=v^2\cdot \frac{\partial^2u}{\partial x^2}$$

其中, $v=\sqrt{E/\sigma}$, 为地震波的传播速度; $E$为弹性介质的杨氏模量.

!!! warning "三维 P 波波动方程"
	$$v_P=\frac{\lambda+2\mu}{\sigma}$$
"""

# ╔═╡ 455a4046-7f35-4c2d-b246-3db3fc5ef9bc
md"""
## 2.2 地震波的传播： S波波动方程

![](https://box.nju.edu.cn/f/5efceca1556f427bbfd6/?dl=1)

$$\frac{\partial^2 w}{\partial t^2}=\beta^2\frac{\partial^2w}{\partial x^2}$$

其中, $\beta=\sqrt{\mu/\sigma}$, 为地震波的传播速度; $\mu$为弹性介质的剪切模量.
"""

# ╔═╡ 4978275d-e120-41df-89e8-4203f4bff4bf
md"""
## 2.2 地震波的传播： 波动方程通解
!!! danger "波动方程的解?"
	$$\frac{\partial^2u}{\partial t^2}=v^2\cdot \frac{\partial^2u}{\partial x^2}$$
	$$u(x,t)=?$$

!!! tip "通解"
	$$u(x,t) = f(t-\frac{x}{v})$$
	
!!! tip "适合地震波简谐振动的表示形式"
	$$u(x)=A\cos\omega(t-\frac{x}{v})=A\cos2\pi(\frac{t}{T}-\frac{x}{\lambda})=A\cos(\omega t-kx)$$
	v: 地震波速度; 
	A: 振幅; 
	$\lambda=vT$: 波长;
	T: 周期;
	$\omega$: 角频率;
	$f=\omega/2\pi=1/T$: 频率
	$k=\omega/v=2\pi/\lambda$: 波数;
	$\omega t-kx$: 简谐波的相位

![](https://box.nju.edu.cn/f/e3a24c1dbcec42009ead/?dl=1)
"""

# ╔═╡ 6a92bc1b-1d4a-4ee2-a8f2-5aa87e0f27a2
md"""
## 2.2 地震波的传播： 波阵面与射线
![](https://box.nju.edu.cn/f/61bb2e372c334fffa93c/?dl=1)
![](https://box.nju.edu.cn/f/74515b88ad4d436fb09b/?dl=1)
!!! tip "波阵面 & 地震射线"
	* 在给定时刻 t, 由相位相同的各点构成的曲面, 称为波阵面.
	* 地震射线与波阵面垂直, 它指示地震波的传播方向与路径.
	* 平面波的波阵面是平面; 点源产生的体波呈球面状波阵面.
"""

# ╔═╡ 7554951b-9faa-4685-bbdf-d9698c2bf8ee
md"""
## 2.2 地震波的传播： P&S 质点振动
!!! note "P 波"
	质点振动方向与传播方向一致, 速度最快, 是最早到达的波
![](https://box.nju.edu.cn/f/7f11319584f94f21aabb/?dl=1)

!!! warning "S 波"
	质点振动方向与传播方向垂直, 分为 SV 和 SH 波
![](https://box.nju.edu.cn/f/6d59a9de2b904dec99ca/?dl=1)

"""

# ╔═╡ 440942d3-afc0-4204-97c7-b0030a8a08e4
md"""
## 2.2 地震波的传播： 地震波的衰减

地震波振幅随震源距离增加而减小的现象称为衰减, 它与波阵面的形状和波传播经过介质的弹性性质有关, 分别称为**几何扩散**和**介质吸收**两种衰减方式.

#### 几何扩散
地震波的初始能量为$E_b$, 则在半径为$r$的半球面($2\pi r^2$)上, 体波的能量密度$I_b$为:

$$I_b = E_b / 2 \pi r^2$$

对球面波来讲, 地震波的波阵面为一深度为$d$的圆柱面($2 \pi r d$),在距离震源$r$处的面波的能量密度$I_s$为:

$$I_s = E_s / 2 \pi r d$$

体波的几何衰减与$1/r^2$成正比, 面波的几何衰减与$1/r$成正比. 因此, **体波衰减的更快**.

#### 介质吸收
地球介质并非完全弹性, 地震波在传播过程中能量被吸收而导致振幅衰减, 一般用品质因子$Q$来描述.
$Q$定义为在一周期(或一波长距离)内振动损耗的能量$\Delta E$与总能量$E$之比的倒数.

$$\frac{2\pi}{Q} = - \frac{\Delta E}{E}$$

* 介质的$Q$值越大, 地震波能量的损耗越小.
* 同一介质中 P 波和 S 波的品质因子$Q_P$和$Q_S$不同.

如果能量衰减与距离成正比, 对于一个波长$\lambda$的能量衰减, $\Delta E= \lambda dE/dr$, 有

$$\frac{dE}{E}=-\frac{2\pi dr}{\lambda Q}$$

由于 $E\propto A^2$, 因此 $dE/E = 2dA/A$, 有

$$\frac{dA}{dr} = -\frac{\pi A}{\lambda Q}$$

$$A=A_0 e^{-\frac{\pi}{\lambda Q}r}=A_0 e^{-br}$$

其中, $b=\pi/\lambda Q$称为地震波的振幅衰减系数, 它与波长$\lambda$成反比, 与频率成正比. 因此, 地震波的**高频信号比低频信号衰减的更快**.

"""

# ╔═╡ b62243ed-9daf-4db7-ae00-2a10a956f286
md"""
## 2.3 地震波的反射与折射： 波阵面传播
"""

# ╔═╡ d3613a36-78a6-444f-8499-771faaaba4f8
html"""
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/c918a5cbbbd145758579/?dl=1" type="video/mp4">
</video>

"""

# ╔═╡ 5f041710-7c5f-40ff-a0af-40998ff6b2ea
md"""
## 2.3 地震波的反射与折射： 斯奈尔定律

"""

# ╔═╡ 2089a015-95a4-44a9-8245-87424cc327d4
TwoColumn21(md"""
![](https://box.nju.edu.cn/f/c4c02278c5d74608b8b6/?dl=1)

""",
md"""
\


$$\frac{\sin\theta_{P1}}{v_{P1}}= \frac{\sin\theta '_{P1}}{v_{P1}}=\frac{\sin\theta '_{S1}}{v_{S1}}\equiv p$$
$$\frac{\sin\theta_{P1}}{v_{P1}}= \frac{\sin\theta_{P2}}{v_{P2}}=\frac{\sin\theta_{S2}}{v_{S2}}\equiv p$$

!!! tip "射线参数" 
	 $p$为射线参数， 一条地震射线在反射、折射的过程中， 射线参数保持不变。

"""
)

# ╔═╡ 6dc2baad-601d-4967-a4f8-4bf17c44804b
TwoColumn21(
md"""
![](https://box.nju.edu.cn/f/98e4f15397e045758f67/?dl=1)
""",
md"""
\
\
\


$$\frac{\sin\theta_i}{v_i}=p$$


"""
	
)

# ╔═╡ 9d7e31cd-1b56-426b-99b9-8892258e51c2
md"""
## 2.3 地震波的反射与折射： 费马原理
"""

# ╔═╡ 99cf2398-9fba-4e43-b16a-a809e4f106a4
TwoColumn21(
md"""
!!! warning "地震波沿时间最短的路径传播"
![](https://box.nju.edu.cn/f/13aebeff4a3f46038375/?dl=1)
""",
md"""
\
\


$$t(x)=\frac{AO}{v_1}+\frac{OB}{v_2}$$

$$t(x)=\frac{\sqrt{h^2+x^2}}{v_1}+\frac{\sqrt{b^2+(d-x^2)}}{v_2}$$

由$\frac{dt}{dx}=0$，可得

$$\frac{x}{v_1\sqrt{h^2+x^2}}+\frac{-(d-x)}{v_2\sqrt{b^2+(d-x)^2}}=0$$

$$\frac{\sin\theta_1}{v_1}=\frac{\sin\theta_2}{v_2}$$
"""
)

# ╔═╡ d989ffad-40d9-4189-bed8-7b72906d4b04
md"""
`dx = ` $@bind dx html"<input type=range min=100 max=200 step=5 >"

`hx = ` $(@bind hx html"<input type=range min=10 max=50  step=2 >")

`bx = ` $(@bind bx html"<input type=range min=10 max=50  step=2 >")

`v1 = ` $(@bind v1 html"<input type=range min=5.5 max=6.5  step=0.1 >")

`v2 = ` $(@bind v2 html"<input type=range min=7.0 max=8.0  step=0.1 >")
"""

# ╔═╡ 36d9c896-d738-4721-bb01-f2ea9791687d
println(dx,"\n",hx,"\n", bx, "\n",v1, "\n",v2)

# ╔═╡ b88f206b-1aee-4205-b754-244085354620
begin	
	t(x) = √(hx^2+x^2)/v1 + √(bx^2+(dx-x)^2)/v2
	x  = 0:0.1:100;
	tx = t.(x)
	plot(x,tx,lw=3)
	xlabel!("x")
	ylabel!("t(x)")
	minx = findmin(tx)
	scatter!((x[minx[2]], minx[1]),markersize=9)
end

# ╔═╡ 1387d2b4-336c-4541-8af0-ad27f2be397b
xmin=x[minx[2]]

# ╔═╡ b6d9a5d8-b72f-43f4-89d0-f95567daba5c
(xmin/√(hx^2+xmin^2)/v1) - ((dx-xmin)/√(bx^2+(dx-xmin)^2)/v2)

# ╔═╡ a196bee2-c57d-48f6-aa93-9a7335009c07
md"""
## 2.3 地震波的反射与折射： 惠更斯原理
"""

# ╔═╡ 9d2e7a09-e51b-4a5c-881e-5d163a1bda0f
TwoColumn(
md"""
!!! warning "波阵面上任意一点都是一个新的点源"
![](https://box.nju.edu.cn/f/a59174cacc36472b906b/?dl=1)
""",
md"""
![](https://box.nju.edu.cn/f/c7c903cefe6549feb3d6/?dl=1)
"""
	
)

# ╔═╡ b3ea7895-c9ed-4fdf-93b4-dee73af71b3b
TwoColumn(md"""
![](https://box.nju.edu.cn/f/800977dea43d41508799/?dl=1)
""",md"""
!!! tip "惠更斯原理"
	* 0时刻， 波阵面为 AC
	* t时刻， 波阵面为 EB
	*  $BC=v_1\cdot t$, $AE=v_2\cdot t$
	*  $AB=BC/\sin\theta_1=AE/\sin\theta_2$
	$$\frac{\sin\theta_1}{\sin\theta_2}=\frac{BC}{AE}=\frac{v_1}{v_2}$$
""")

# ╔═╡ 115c283a-4b41-4ae4-8642-9975ad9466ff
md"""
## 2.3 地震波的反射与折射： 地震波在界面的转换
![](https://box.nju.edu.cn/f/04c8558ad9b84224a8e2/?dl=1)
"""

# ╔═╡ 650ea9fe-fd64-4b2b-82e0-b1c616a98527
md"""
## 2.3 地震波的反射与折射： 反射与透射系数
!!! tip "定义"
	*  $A_0, A_1, A_2$分别是入射波、反射波、透射波的振幅
	* 反射系数$R=A_1/A_0$
	* 透射系统$T=A_2/A_0$

!!! note "垂直入射"
	*  $v_1, \sigma_1$为介质1的速度与密度
	*  $v_2, \sigma_2$为介质2的速度与密度
	*  $Z=v\cdot\sigma$定义为波阻抗
	$$R=\frac{A_1}{A_0}=\frac{\sigma_2 v_2 - \sigma_1 v_1}{\sigma_2 v_2 + \sigma_1 v_1}=\frac{Z_2-Z_1}{Z_2+Z_1}$$
	$$T=\frac{A_2}{A_0}=\frac{2\sigma_1 v_1}{\sigma_2 v_2 + \sigma_1 v_1}=\frac{2Z_1}{Z_2+Z_1}$$
![](https://box.nju.edu.cn/f/bfcaad6f5066494d85ae/?dl=1)
!!! tip "垂直入射"
	*  反射波振幅总小于入射波， 相位可正可负
	*  透射波振幅可以**大于**入射波， 相位与入射波相同
"""

# ╔═╡ 3c740f2b-c2f5-46f2-a2ec-0ac33811afc9
Foldable("为什么沉积盆地对地面振动有放大效应？", 
	md"""
	对于透射波， $Z_1>Z_2$， 故$T>1$, 透射波振幅被放大。
	
	"""
)

# ╔═╡ 0d125718-073b-490b-bad9-1e3082c474ba
md"""
## 2.3 地震波的反射与折射： 反射与透射系数
!!! note "倾斜入射"
	与波阻抗、波速比、入射角等多个因素有关。
	*  $\gamma=v_{s}/v_{p}$为波速比
	*  $Z=\sigma v_{p}$、$W=\sigma v_{s}$为 P 波和 S 波波阻抗
	*  $\alpha$、$\beta$为 P 波和 S 波入射角与透射角

!!! danger "Zoeppritz方程"
	$$A_1\cos\alpha_1-B_1\sin\beta_1+A_2\cos\alpha_2+B_2\sin\beta_2=A_0\cos\alpha_1$$
	$$A_1\sin\alpha_1+B_1\cos\beta_1-A_2\sin\alpha_2+B_2\cos\beta_2=-A_0\sin\alpha_1$$
	$$A_1Z_1\cos2\beta_1-B_1W_1\sin2\beta_1-A2Z2\cos2\beta_2-B_2W_2\sin2\beta_2=-A_0Z_1\cos2\beta_1$$
	$$A_1\gamma_1W_1\sin2\alpha_1+B_1W_1\cos2\beta_1+A_2\gamma_2W_2\sin2\alpha_2-B_2W_2\cos2\beta_2=A_0\gamma_1W_1\sin2\alpha_1$$

![](https://box.nju.edu.cn/f/d5a26b5388f24630bb17/?dl=1)

"""

# ╔═╡ Cell order:
# ╠═7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
# ╠═5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
# ╠═232c59fa-77b2-470c-ae85-fa8e8b14c301
# ╟─aaa0f3cc-f507-4f12-a611-0560fe8ecb24
# ╟─818bbfd3-181a-49fa-8e11-e61fc921cee8
# ╟─400ae1f1-4ee9-4f48-9fda-1f46918c452c
# ╟─5dd5c144-636f-4426-a41b-d09b7ef6932d
# ╟─a7af5c78-16c9-49f5-b2d1-216b564aefb1
# ╠═c663c599-239d-4e5a-9d4b-2337eda0d6ba
# ╠═6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
# ╟─69d6d08f-b03f-4975-9974-6daacbf2576f
# ╟─08282040-eefc-4d50-b842-f2117e071f49
# ╟─a94a1f96-59ea-4447-a9e6-d3012549259c
# ╟─205a4f51-11c1-4b5e-8cf2-049cefe8c702
# ╟─ecec4a61-f93e-4358-bdb7-008cdf4dcdd1
# ╟─8f3649f9-8a22-4838-927f-2ac7c1f7bc7e
# ╟─befe5e18-50a1-4b2c-83ef-7687d59c503d
# ╟─81561842-82f9-4a36-9b72-595535e20f3c
# ╟─b542a667-4c43-41f6-89ee-129da08bc401
# ╟─455a4046-7f35-4c2d-b246-3db3fc5ef9bc
# ╟─4978275d-e120-41df-89e8-4203f4bff4bf
# ╟─6a92bc1b-1d4a-4ee2-a8f2-5aa87e0f27a2
# ╟─7554951b-9faa-4685-bbdf-d9698c2bf8ee
# ╟─440942d3-afc0-4204-97c7-b0030a8a08e4
# ╟─b62243ed-9daf-4db7-ae00-2a10a956f286
# ╟─d3613a36-78a6-444f-8499-771faaaba4f8
# ╟─5f041710-7c5f-40ff-a0af-40998ff6b2ea
# ╟─2089a015-95a4-44a9-8245-87424cc327d4
# ╟─6dc2baad-601d-4967-a4f8-4bf17c44804b
# ╟─9d7e31cd-1b56-426b-99b9-8892258e51c2
# ╟─99cf2398-9fba-4e43-b16a-a809e4f106a4
# ╟─d989ffad-40d9-4189-bed8-7b72906d4b04
# ╠═36d9c896-d738-4721-bb01-f2ea9791687d
# ╠═b88f206b-1aee-4205-b754-244085354620
# ╟─1387d2b4-336c-4541-8af0-ad27f2be397b
# ╠═b6d9a5d8-b72f-43f4-89d0-f95567daba5c
# ╟─a196bee2-c57d-48f6-aa93-9a7335009c07
# ╟─9d2e7a09-e51b-4a5c-881e-5d163a1bda0f
# ╟─b3ea7895-c9ed-4fdf-93b4-dee73af71b3b
# ╟─115c283a-4b41-4ae4-8642-9975ad9466ff
# ╟─650ea9fe-fd64-4b2b-82e0-b1c616a98527
# ╟─3c740f2b-c2f5-46f2-a2ec-0ac33811afc9
# ╟─0d125718-073b-490b-bad9-1e3082c474ba
