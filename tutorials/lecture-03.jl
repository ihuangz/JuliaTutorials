### A Pluto.jl notebook ###
# v0.19.40

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

# ╔═╡ 33ccd537-badb-49cb-bc31-8f6f10011ca9
md"""
## 2.x 思考题
* 分别利用费马原理和惠更斯原理推导反射波的Snell定律.
* 利用垂直入射的反射与透射系数,解释**地表反射波振幅反转**与**沉积盆地透射波振幅放大**现象.
"""

# ╔═╡ 354ed098-3bdf-4bb1-a81a-164d6fdcb075
md"""
# Lecture 3: 地震波走时曲线

!!! note "提纲"
	* 近震走时方程与走时曲线
	* 球对称地球模型中的地震射线
	* 远震震相与走时曲线

![](https://box.nju.edu.cn/f/ab40ca224da04c1f80eb/?dl=1)
"""

# ╔═╡ 43d4d0ee-c1a2-45c4-8d4c-01ed4efe209d
md"""
## 3.0 地球主要圈层/速度界面的发现
"""

# ╔═╡ 9a8fd145-dea7-4a5c-9eec-c1c48f7c7351
TwoColumn(2/3,"center","center",
md"""
!!! note "壳-幔分层： 莫霍面"
""",
Foldable("关键证据", 	
md"Pn 波， 地幔高速公路"
)
)


# ╔═╡ 5a396c09-7f58-4319-8c61-d4a780b0f734
TwoColumn(0.7,"center","center",
md"""
![](https://box.nju.edu.cn/f/ca24539fc6164b8dbbd5/?dl=1)
""",
md"""
1909年， 南斯拉夫的莫霍洛维奇发现地球内部有**高速层**
![](https://box.nju.edu.cn/f/ff9af07cf201486b9b37/?dl=1)
"""
	
)

# ╔═╡ bcc1aa36-b4c7-4f5a-9879-4b163e6e8486
TwoColumn(2/3,"center","center",
md"""
!!! note "核-幔分层： 核幔边界（CMB）"
""",
Foldable("关键证据", 	
md"P波影区"
)
)


# ╔═╡ a0e5661c-1d6f-4daf-a8b8-6913a0d189e7
TwoColumn(60,"center","center",
md"""
![](https://box.nju.edu.cn/f/dd743fd16e2b444bb259/?dl=1)
""",
md"""
1914年， 德国地球物理学家古登堡发现地球深部是**液态**的
![](https://box.nju.edu.cn/f/f1596cd1379648d1875f/?dl=1)
"""
	
)

# ╔═╡ 13ae3631-c1fb-4af0-8bbc-f4b4b2ad1d46
TwoColumn(2/3,"center","center",
md"""
!!! note "内-外核分层： 内核边界（ICB）"
""",
Foldable("关键证据", 	
md"在 P 波影区发现的 P 波： PKiKP"

)
)

# ╔═╡ 09c646dc-4f38-4e11-97a4-77b83de7295b
TwoColumn(2/3,"center","center",
md"""
![](https://box.nju.edu.cn/f/6ebd005364314249a8f3/?dl=1)
""",
md"""
1936年， 丹麦地球物理学家莱曼提出地球有**固态内核**
![](https://box.nju.edu.cn/f/8d81fcadd715445385c3/?dl=1)
"""
	
)

# ╔═╡ 062a4836-dd73-4b90-beee-d95d550ec349
md"""
## 3.1 近震走时方程与走时曲线
"""

# ╔═╡ 427953bf-f85b-4f5b-8549-e580543d6e0d
md"""
在地震记录图上， 不同震中距的地震波形不同。
![](https://box.nju.edu.cn/f/92aa5a61ad3c46b1af7e/?dl=1)

"""

# ╔═╡ 43542b3e-9f48-4302-bcdb-e326435de9e0
md"""
近震射线路径主要可以分为三类：
1. 从震源直接到达台站的**直达波**：$P^*, S^*$
1. 经康拉德面/莫霍面滑行到达台站的**折射波**: $Pb, Sb; Pn, Sn$
1. 在莫霍面反射到达台站的**反射波**： $PmP, SmS$
![](https://box.nju.edu.cn/f/0859b10e6f774dc29a9a/?dl=1)
"""

# ╔═╡ c0c029d8-4e62-420f-959e-0a898cc242ae
html"""
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/dae923357a3840d9b1df/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ 8330cbcf-4ec7-4901-bbb6-e724c24b0eb2
html"""
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/b1aec18bb1f54519941c/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ 26212dc3-2c1f-45ac-a98b-1d4ada8d8f56
md"""
## 3.1 近震走时方程与走时曲线： 直达波
"""

# ╔═╡ 58f4a080-3df6-4ea4-acd8-be1a0432536e
TwoColumn(1/2,"center","start",
md"""
![](https://box.nju.edu.cn/f/b6eeec31030f4ac1b033/?dl=1)
""",
md"""
!!! tip "直达波"

$$t=\frac{OS}{v_1}=\frac{\sqrt{\Delta^2+h^2}}{v_1}$$
整理得：

$$\frac{t^2}{t_0^2}-\frac{\Delta^2}{h^2}=1$$

!!! note "曲线特点"
	* 走时方程为双曲线， 其渐近线为$t=\Delta/v_1$， 与t 轴截距为$t_0=h/v_1$
	*  $h=0$时，转变为一条直线， 当$\Delta\gg h$时， 可近似
"""
	
)

# ╔═╡ d72a773a-a6d2-4bcd-bb93-fde0ca86c441
@bind Δ html"Distance = <input type=number value=200 min=100 max=200> "

# ╔═╡ c33539f9-f95d-4356-a0e5-e805409448fc
@bind h html"Focus depth = <input type=number value=10 min=0 max=25>"

# ╔═╡ c5615dfc-1e8c-4060-b63d-15039d5781bb
@bind H html"Moho depth = <input type=number value=30 min=25 max=50>"

# ╔═╡ 873b9dac-e5a2-4281-afd2-db6a8692053d
@bind v1 html"Crustal velocity = <input type=number value=6.0 min=5.5 max=6.5 step=0.1>"

# ╔═╡ 9565b00e-ed96-477e-8d18-9bae252d21c3
@bind v2 html"Mantle velocity = <input type=number value=8.0 min=7.0 max=8.5 step=0.1>"

# ╔═╡ e37048a9-43c6-4112-b0c1-1df079766fdf
begin
	x = 0:1:Δ
	t1(x) = √(x^2+h^2)/v1
	t2(x) = √(x^2+(2H-h)^2)/v1
	θ0 = asin(v1/v2)
	t3(x) = x/v2+(2H-h)*cos(θ0)/v1
end

# ╔═╡ 7373ccd3-cd2b-4ffe-9048-6f1e99ec52ba
begin
	plot(x,x./v1,ls=:dash,xlims=[0, 200],ylims=[0, 35],label="Ref.")
	plot!(x,t1.(x),lw=2,label="P*")
	plot!(x,t2.(x),lw=2,label="PmP")
	plot!(x,t3.(x),lw=2,ls=:dashdot,label="Pn")
	plot!(x,x./v2,ls=:dash,label="Ref2.")
	xlabel!("Distances (km)")
	ylabel!("Travel times (s)")
end

# ╔═╡ 61bfdca6-7a12-4429-bc7c-eef7791aab56
begin
	plot(x,x./v1,ls=:dash,xlims=[0, 200],ylims=[0, 35],label="Ref.")
	plot!(x,t1.(x),lw=2,label="P*")
	xlabel!("Distances (km)")
	ylabel!("Travel times (s)")
end

# ╔═╡ 9544a1d7-ee1c-42d1-9c04-94fa878e442c
md"""
## 3.1 近震走时方程与走时曲线： 反射波
"""

# ╔═╡ c6be87d7-e32f-443f-a4a5-ba0ec25632ec
TwoColumn(1/2,"center","start",
md"""
![](https://box.nju.edu.cn/f/b6eeec31030f4ac1b033/?dl=1)
""",
md"""
!!! tip "反射波"

$$t=\frac{OC+CS}{v_1}=\frac{O_*S}{v_1}=\frac{\sqrt{\Delta^2+(2H-h)^2}}{v_1}$$
整理得：

$$\frac{t^2}{t_0^2}-\frac{\Delta^2}{(2H-h)^2}=1$$

!!! note "曲线特点"
	* 走时方程为双曲线， 其渐近线为$t=\Delta/v_1$， 与t 轴截距为$t_0=(2H-h)/v_1$
"""
	
)

# ╔═╡ 859551e6-25d8-4b40-b9e8-5419efcf4491
begin
	plot(x,x./v1,ls=:dash,xlims=[0, 200],ylims=[0, 35],label="Ref.")
	plot!(x,t1.(x),lw=2,label="P*")
	plot!(x,t2.(x),lw=2,label="PmP")
	xlabel!("Distances (km)")
	ylabel!("Travel times (s)")
end

# ╔═╡ 7be8a94c-0642-4dd9-b078-c17a63d982d2
md"""
## 3.1 近震走时方程与走时曲线： 折射波
"""

# ╔═╡ 469c96c9-2a7b-4a26-a962-15235db329f8
TwoColumn(1/2,"center","start",
md"""
![](https://box.nju.edu.cn/f/b6eeec31030f4ac1b033/?dl=1)
""",
md"""
!!! tip "折射波"
	* 入射角达到临界角： $\sin\theta_0=v_1/v_2$

$$t =\frac{OA+BS}{v_1}+\frac{AB}{v_2}$$

$$t=\frac{2H-h}{v_1\cos\theta_0}+\frac{\Delta-(2H-h)\tan\theta_0}{v_2}$$
整理得：

$$t=\frac{\Delta}{v_2}+\frac{(2H-h)\cos\theta_0}{v_1}$$

!!! note "曲线特点"
	* 走时方程为直线， 斜率$t=\Delta/v_2$， $t$ 轴截距为$t_0=(2H-h)\cos\theta_0/v_1$
"""
	
)

# ╔═╡ 66978593-9838-4637-9656-62930c6bd280
begin
	plot(x,x./v1,ls=:dash,xlims=[0, 200],ylims=[0, 35],label="Ref.")
	plot!(x,t1.(x),lw=2,label="P*")
	plot!(x,t2.(x),lw=2,label="PmP")
	plot!(x,t3.(x),lw=2,ls=:dashdot,label="Pn")
	plot!(x,x./v2,ls=:dash,label="Ref2.")
	xlabel!("Distances (km)")
	ylabel!("Travel times (s)")
	Δ0 = (2H-h)*tan(θ0)
	#println("Δ0=",Δ0)
	Δc = (2H-h)*√((v2+v1)/(v2-v1))
	#println("Δc=",Δc)
	plot!([Δ0, Δ0],[0, 30],lw=0.5,lc=:blue,ls=:dash,label=L"\Delta_0")
	plot!([Δc, Δc],[0, 30],lw=0.5,lc=:red,ls=:dash,label=L"\Delta_c")
end

# ╔═╡ a2e88659-c69b-41de-beb4-5644c721bab5
md"""
!!! tip "折射波"
	* 当$\theta_0$达到临界角时，才会发生折射，形成折射波，对应盲区半径为 $\Delta_0=(2H-h)\tan\theta_0$
	* 在特定震中距$\Delta_c$后，折射波最早到达，称为首波。
	  $$\Delta_c=2H\sqrt{\frac{v_2+v_1}{v_2-v_1}}$$

"""

# ╔═╡ 17774f64-724b-4367-8a3b-4384dbf50e8d
md"""
## 3.2 远震走时方程
"""

# ╔═╡ d30df699-3799-424f-b0b2-d8a1ad6268b9
html"""
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/dc87fc17d61748508ac8/?dl=1" type="video/mp4">
</video>

"""

# ╔═╡ dec056ba-16c4-4b2b-b5b0-860cd67e02df
TwoColumn(0.65,"center","start",
md"""
#### 球对称介质中的 Snell 定律
![](https://box.nju.edu.cn/f/40759dbadbb245e3aee9/?dl=1)
""",
md"""
在$A_1$点: 

$$\frac{\sin i_1}{v_1}=\frac{\sin i_1^{'}}{v_2}$$

在$\triangle  OA_1A_2$中，据正弦定理：

$$\frac{\sin(\pi-i_2)}{r_1}=\frac{\sin i_1^{'}}{r_2}$$

因此：

$$\frac{r_1\sin i_1}{v_1}=\frac{r_2\sin i_2}{v_2}$$

"""
)

# ╔═╡ 20e42465-a33c-4be1-b938-1b9ac3cbfd20
md"""
!!! tip "球对称介质中的 Snell 定律"
	$\frac{r_n\sin i_n}{v_n} = \frac{r_0\sin i_0}{v_0}=p, (n = 1,2,3,...)$

!!! tip "速度连续变化球对称介质中的 Snell 定律"
	$\frac{r\sin i}{v(r)} =p$
	* 若速度$v(r)$随深度连续增加， $dv/dr<0$，地震射线是一条凸向球心的光滑曲线。
	* 在地震射线最深点处,$i_P=90°$, $p=r_P/v(r_P)$。因此，可以通过射线参数$p$确定地震射线穿透最深处的深度及地球半径。
"""

# ╔═╡ c7f61206-5147-45cf-9f58-45cfe0a03310
md"""
## 3.2 远震走时方程
![](https://box.nju.edu.cn/f/3ef4478ce0fd44a8b102/?dl=1)
!!! tip "参数方程"
	震中距$\theta$和走时$t$均通过半径$dr$积分获取
"""

# ╔═╡ ed6afa64-33a6-4749-9be5-66c5a2f15e43
TwoColumn(1/2,"start","start",
md"""
#### 震中距
在$\triangle ABC$中：

$$ds^2=dr^2+(r\cdot d\theta)^2$$

$$\sin i = \frac{r\cdot d\theta}{ds}$$

因此：

$$d\theta=\pm\frac{\sin i}{\cos i}\frac{dr}{r}$$

根据$$p=r\sin i/v(r)$$：

$$\frac{d\theta}{dr}=\pm\frac{p}{r\sqrt{\frac{r^2}{v^2(r)}-p^2}}$$
""",
md"""
#### 走时
同理：

$$dt=\frac{ds}{v(r)}=\frac{r\cdot d\theta}{v(r)\sin i}$$

$$dt=\pm\frac{r}{v(r)\sin i}\frac{\sin i}{\cos i}\frac{dr}{r}=\pm\frac{dr}{v(r)\cos i}$$

化简有：

$$\frac{dt}{dr}=\pm\frac{r}{v^2(r)\sqrt{\frac{r^2}{v^2(r)}-p^2}}$$
"""
)

# ╔═╡ 91410d65-8119-4beb-b2ce-77a88f31e188
TwoColumn(1/3,"center","start",
md"""
!!! danger "球对称介质中射线的走时方程"
	$$\theta(p) = 2\int_{r_p}^{R}\frac{p}{r\sqrt{\frac{r^2}{v^2(r)}-p^2}}\cdot dr$$

	$$t(p) = 2\int_{r_p}^{R}\frac{r}{v^2(r)\sqrt{\frac{r^2}{v^2(r)}-p^2}}\cdot dr$$

""",
md"""
![](https://box.nju.edu.cn/f/ab40ca224da04c1f80eb/?dl=1)
"""
)

# ╔═╡ d8fcd520-7da8-4c89-813a-35771954d098
TwoColumn(1/2,"center","start",
md"""
#### 本多夫定律
**射线参数$p$与走时曲线的关系**
![](https://box.nju.edu.cn/f/66e4659b8b0f48c6aacb/?dl=1)
""",
md"""
在$\triangle AA^{'}B$中：

$$dt=\frac{ds}{v_0}$$

$$ds=d\Delta\sin i_0=Rd\theta\sin i_0=v_0 dt$$

因此：

$$\frac{dt}{d\theta}=\frac{R\sin i_0}{v_0}=p$$

$$v_0=\frac{d\Delta}{dt}\sin i_0=v^*\sin i_0$$

"""
)

# ╔═╡ f96ac826-be1d-42f5-85a5-f691741a618a
md"""
!!! danger "本多夫定律"
	* 射线参数$p$等于走时曲线$t-\theta$图上该**点**对应的斜率
* 一条走时曲线,代表无数条射线	
*  $v_*=d\Delta/dt$称为视速度，它一般大于真速度$v_0(=ds/dt)$
"""

# ╔═╡ f200cd30-66ca-44a3-8e76-f54103e4955f
md"""
## 3.3 远震震相与走时曲线
"""

# ╔═╡ 2802e954-01e8-4f6d-954c-380a63b23303
TwoColumn(1/2,"center","start",
md"""
#### 全球地震观测
![](https://box.nju.edu.cn/f/a51bfecf94004b7a9178/?dl=1)
""",
Foldable("走时曲线",
md"""
![](https://box.nju.edu.cn/f/5b38d52122404ad5ba9d/?dl=1)
"""
)
)

# ╔═╡ 7e26a5dc-2597-4b84-bd71-237ad8516af5
TwoColumn(0.55,"center","start",
md"""
![](https://box.nju.edu.cn/f/c5f8b79a43334af99ae9/?dl=1)
""",
md"""
$~$
!!! note "地震震相"
	* P: 地幔中传播的 P 波
	* S: 地幔中传播的 S 波
	* K: 外核中传播的 P 波
	* I: 内核中传播的 P 波
	* J: 内核中传播的 S 波
	* c: 核幔边界(CMB)外表面反射波 
	* i: 内核边界(ICB)外表面反射波

"""
	
)

# ╔═╡ 91f37edc-beee-45d6-a14b-623a3d070592
TwoColumn(0.56,"center","start",
md"""
![](https://box.nju.edu.cn/f/53e35dd1c16e4360b7c9/?dl=1)
""",
md"""
!!! tip "深源地震震相"
	* p: 震源直接向地表传播的P波
	* s: 震源直接向地表传播的S波
"""
)

# ╔═╡ 0c281341-61f9-479b-9a16-c696d250e972
md"""
!!! danger "所有的反射、折射、转换均满足Snell定律!!!"
"""

# ╔═╡ e04f581a-9724-4898-b1d9-a244fe9172ab
md"""
## 3.3 远震震相与走时曲线
!!! warning "走时曲线为什么会弯曲?"
	*  $d^2t/d\theta^2$表示曲线的凹凸性质: $>0$表示凹,$<0$表示凸

$$\frac{d^2t}{d\theta^2}=\frac{d}{d\theta}\frac{dt}{d\theta}=\frac{d}{d\theta}\frac{r_p}{v(r_p)}$$

$$\frac{d^2t}{d\theta^2}=\frac{1}{v^(r_p)}\left[ v(r_p)\cdot\frac{dr_p}{d\theta}-r_p\cdot\frac{dv(r_p)}{d\theta}\right]$$

$$\frac{d^2t}{d\theta^2}=\color{blue}\frac{r_p}{v^2(r_p)}\color{black}\left[ \frac{v(r_p)}{r_p}-\frac{dv(r_p)}{dr_p}\right] \color{red}{\frac{dr_p}{d\theta}}$$

*  $走时曲线的形状取决于\left[ \frac{v(r_p)}{r_p}-\frac{dv(r_p)}{dr_p}\right]$
	
* 对正常地球,速度随深度增加,$d^2t/d\theta^2$总为负,走时曲线向上凸

"""

# ╔═╡ 0278bc83-05cc-4324-81d9-e1ff89e647de
md"""
!!! tip "存在低速层时, 走时曲线出现影区"
![](https://box.nju.edu.cn/f/7a9999811fb948fcb975/?dl=1)
"""

# ╔═╡ 827556d4-0bfe-41f6-bde5-c2e12201b40a
md"""
!!! tip "存在高速度梯度层时, 走时曲线出现折叠交叉"
![](https://box.nju.edu.cn/f/6185f8e40bd244eb84be/?dl=1)
"""

# ╔═╡ 83ec46b1-8b74-4342-be31-834f4aa567a2
md"""
## 3.x 思考题
* 反射波能够成为走时最小的近震震相吗?
* 什么是本多夫定律?
* 下列震相是否存在: sPP, PKPS, SKSP, PKiKP, SKJKP, SKSSKS, SSSSS  
"""

# ╔═╡ 79a2cf2b-b7d6-4457-a3b1-d6a0530cc8e3
zsh"""
gmt begin ./img/test png
    gmt coast -R100/150/20/50 -JM3i -Di -W1.0p -A2000 -Bx5 -By5 -BWSEN
gmt end
"""

# ╔═╡ Cell order:
# ╟─7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
# ╟─5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
# ╟─aaa0f3cc-f507-4f12-a611-0560fe8ecb24
# ╟─400ae1f1-4ee9-4f48-9fda-1f46918c452c
# ╟─6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
# ╟─08282040-eefc-4d50-b842-f2117e071f49
# ╟─d242187f-6179-49d1-a32a-1c750e173005
# ╟─33ccd537-badb-49cb-bc31-8f6f10011ca9
# ╠═354ed098-3bdf-4bb1-a81a-164d6fdcb075
# ╟─43d4d0ee-c1a2-45c4-8d4c-01ed4efe209d
# ╟─9a8fd145-dea7-4a5c-9eec-c1c48f7c7351
# ╟─5a396c09-7f58-4319-8c61-d4a780b0f734
# ╟─bcc1aa36-b4c7-4f5a-9879-4b163e6e8486
# ╟─a0e5661c-1d6f-4daf-a8b8-6913a0d189e7
# ╟─13ae3631-c1fb-4af0-8bbc-f4b4b2ad1d46
# ╠═09c646dc-4f38-4e11-97a4-77b83de7295b
# ╟─062a4836-dd73-4b90-beee-d95d550ec349
# ╟─427953bf-f85b-4f5b-8549-e580543d6e0d
# ╟─43542b3e-9f48-4302-bcdb-e326435de9e0
# ╠═c0c029d8-4e62-420f-959e-0a898cc242ae
# ╟─8330cbcf-4ec7-4901-bbb6-e724c24b0eb2
# ╟─26212dc3-2c1f-45ac-a98b-1d4ada8d8f56
# ╟─58f4a080-3df6-4ea4-acd8-be1a0432536e
# ╟─d72a773a-a6d2-4bcd-bb93-fde0ca86c441
# ╟─c33539f9-f95d-4356-a0e5-e805409448fc
# ╟─c5615dfc-1e8c-4060-b63d-15039d5781bb
# ╟─873b9dac-e5a2-4281-afd2-db6a8692053d
# ╟─9565b00e-ed96-477e-8d18-9bae252d21c3
# ╟─e37048a9-43c6-4112-b0c1-1df079766fdf
# ╟─7373ccd3-cd2b-4ffe-9048-6f1e99ec52ba
# ╟─61bfdca6-7a12-4429-bc7c-eef7791aab56
# ╟─9544a1d7-ee1c-42d1-9c04-94fa878e442c
# ╟─c6be87d7-e32f-443f-a4a5-ba0ec25632ec
# ╟─859551e6-25d8-4b40-b9e8-5419efcf4491
# ╟─7be8a94c-0642-4dd9-b078-c17a63d982d2
# ╟─469c96c9-2a7b-4a26-a962-15235db329f8
# ╟─66978593-9838-4637-9656-62930c6bd280
# ╟─a2e88659-c69b-41de-beb4-5644c721bab5
# ╟─17774f64-724b-4367-8a3b-4384dbf50e8d
# ╟─d30df699-3799-424f-b0b2-d8a1ad6268b9
# ╟─dec056ba-16c4-4b2b-b5b0-860cd67e02df
# ╟─20e42465-a33c-4be1-b938-1b9ac3cbfd20
# ╟─c7f61206-5147-45cf-9f58-45cfe0a03310
# ╟─ed6afa64-33a6-4749-9be5-66c5a2f15e43
# ╟─91410d65-8119-4beb-b2ce-77a88f31e188
# ╟─d8fcd520-7da8-4c89-813a-35771954d098
# ╟─f96ac826-be1d-42f5-85a5-f691741a618a
# ╟─f200cd30-66ca-44a3-8e76-f54103e4955f
# ╟─2802e954-01e8-4f6d-954c-380a63b23303
# ╟─7e26a5dc-2597-4b84-bd71-237ad8516af5
# ╟─91f37edc-beee-45d6-a14b-623a3d070592
# ╟─0c281341-61f9-479b-9a16-c696d250e972
# ╟─e04f581a-9724-4898-b1d9-a244fe9172ab
# ╟─0278bc83-05cc-4324-81d9-e1ff89e647de
# ╟─827556d4-0bfe-41f6-bde5-c2e12201b40a
# ╟─83ec46b1-8b74-4342-be31-834f4aa567a2
# ╟─79a2cf2b-b7d6-4457-a3b1-d6a0530cc8e3
