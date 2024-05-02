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
# Lecture 4: 地震面波

!!! note "提纲"
	* 面波类型
	* 面波频散
	* 面波敏感核
	* 全球面波

![](https://box.nju.edu.cn/f/8d014555e3df4ee2aca4/?dl=1)
"""

# ╔═╡ c7eea271-ef58-43ff-a55d-a779f1bd8c97
md"""
#### P-SV地震波场
"""

# ╔═╡ 149306e2-3a82-4182-9ce9-03774a235327
html"""
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/c7597e265ab948e6b11d/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ 84784183-6a65-4c3b-8470-b490d6c19a31
md"""
#### P-SV地震波场： 小尺度
![](https://box.nju.edu.cn/f/15e44792957b4db6ac90/?dl=1)
"""

# ╔═╡ 19709b2f-d053-4ca0-b57d-1681c4807283
html"""
<h4> 深源地震P-SV地震波场</h4>
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/92ac2efecf364d5c9f90/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ 84b83efb-3cee-4fcd-9483-285b8a0f428f
html"""
<h4> SH地震波场</h4>
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/ea21f478c27d4edc9b56/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ ff1de6c5-e227-4281-8a3f-40a687216809
md"""
## 4.1 面波类型
* 面波是由体波干涉叠加在界面附近生成的一种次生波
* 振幅随深度增加而迅速减小，能量主要集中在界面附近并沿界面传播
* 面波主要有瑞利波和勒夫波两种基本类型
"""

# ╔═╡ ead32969-d666-4f71-a1df-c8c21408a67c
md"""
!!! note "面波类型： 瑞利波(Rayleigh)"
	* 1885年由英国物理学家Rayleigh首先在理论上导出，后在观测中证实
	* 由 P 波和 SV 波在自由界面耦合形成的非均匀波
	* 瑞利波沿地表传播，位移矢量在垂直于地面的平面内做逆行的椭圆振动
	* 波的振幅在地表最大，随着深度以指数形式减小
	* 瑞利波的波速小于横波波速，泊松比为 0.25 时，瑞利波速度为$c_R=0.9194v_s$

![](https://box.nju.edu.cn/f/2bcf3d71ab1041aba259/?dl=1)
"""

# ╔═╡ 2ca2f007-ca78-4924-acbf-1326920f0884
md"""
!!! note "面波类型： 勒夫波（Love）"
	* 1911年英国物理学家Love提出
	* 由 SH 波相干干涉形成
	* 产生于层状介质中，且要求上覆层横波速度小于下半空间的横波速度
	* 勒夫波振动方向平行于地面，并与传播方向垂直
	* 勒夫波的速度 $c_L$ 介于上下层介质的 S 波速度之间$v_{s1}<c_L<v_{s2}$
	* 勒夫波的速度大于瑞利波速度:$c_L>c_R$

![](https://box.nju.edu.cn/f/f1a8be35af274bdca1ea/?dl=1)
"""

# ╔═╡ a0fe1577-8e97-4ea5-a5c1-005865eae24e
md"""
## 4.2 面波频散
!!! tip "面波传播速度与频率有关这一现象称为频散现象"
![](https://box.nju.edu.cn/f/8d014555e3df4ee2aca4/?dl=1)
"""

# ╔═╡ 56b033f7-2050-4fa3-986e-7b81753c7552
TwoColumn(1/2,"start","start",
md"""
![](https://box.nju.edu.cn/f/63c872f01b7342e6894b/?dl=1)
""",md"""
* 频率愈低(周期长)的面波穿透的深度越深，且深部介质的速度更大
* 因此长周期波传播较快,在面波波列中显示为前段周期大后段周期小，即周期大(频率低)的波先到

![](https://box.nju.edu.cn/f/c2c91895df114c5ebdc0/?dl=1)
"""	
)

# ╔═╡ 1b89be7c-d8d4-407b-8942-c8cead768a19
md"""
## 4.2 面波频散: 频散曲线
![](https://box.nju.edu.cn/f/5d78508b19434ddfa536/?dl=1)
"""

# ╔═╡ 737eb008-a2fa-4fe7-8ba0-e7116a23736e
md"""
## 4.2 面波频散: 相速度与群速度
!!! tip "相速度"
	单频率简谐波的传播速度
!!! tip "群速度"
	多频率简谐波叠加的传播速度

$$sin(\omega t - \frac{\omega}{C} x)$$
"""

# ╔═╡ 4012087a-5915-44a2-84b0-261df092121f
md"""
![](https://box.nju.edu.cn/f/33bb95db29d64b708d4d/?dl=1)
"""

# ╔═╡ 4d98c6a3-a063-4158-8e48-e5573ecffe7f
html"""
<img src="https://box.nju.edu.cn/f/cdfafe652c804102ab3d/?dl=1" width=600>
"""

# ╔═╡ 98f3dd7d-e7d6-434c-9110-9d8d2f61954e
md"""
## 4.3 面波敏感核
* 不同周期面波的相/群速度对不同深度的S波速度的敏感度不同
![](https://box.nju.edu.cn/f/8282f4586db145f09664/?dl=1)

* 因此，可以反演频散曲线，获得地壳和上地幔的S波速度结构
![](https://box.nju.edu.cn/f/e1eaed8f089848b0a0e3/?dl=1)
"""

# ╔═╡ 08430e9e-f39e-4101-9d15-56df7d730358
md"""
## 4.4 全球面波
由于面波能量衰减很慢，大地震产生的面波在绕地球多圈后能量仍十分明显，在一个特定台站可观察到环绕地球不同路径的瑞利型 R 和勒夫型 G 长周期面波.

* 从地震沿**小圆弧**路径到达台站的瑞利波记为 R1, R3, R5, ...
* 从地震沿**大圆弧**路径到达台站的瑞利波记为 R2, R4, R6, ...
"""

# ╔═╡ 22ecbdff-a60e-4445-a2a1-aae5c90f090e
TwoColumn(2/3,"start","start",
md"""
![](https://box.nju.edu.cn/f/279a8c8e3d704a31a30f/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/6563c30abf9a4440b904/?dl=1)
""")


# ╔═╡ 96718528-a59d-41fd-be50-2e0f11e9ea45
md"""
## 4.x 思考题
* 什么是频散现象？ 什么是频散曲线？
* 为什么面波造成的地表破坏比体波大？ 
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
# ╠═149306e2-3a82-4182-9ce9-03774a235327
# ╟─84784183-6a65-4c3b-8470-b490d6c19a31
# ╟─19709b2f-d053-4ca0-b57d-1681c4807283
# ╟─84b83efb-3cee-4fcd-9483-285b8a0f428f
# ╟─ff1de6c5-e227-4281-8a3f-40a687216809
# ╟─ead32969-d666-4f71-a1df-c8c21408a67c
# ╟─2ca2f007-ca78-4924-acbf-1326920f0884
# ╟─a0fe1577-8e97-4ea5-a5c1-005865eae24e
# ╟─56b033f7-2050-4fa3-986e-7b81753c7552
# ╟─1b89be7c-d8d4-407b-8942-c8cead768a19
# ╟─737eb008-a2fa-4fe7-8ba0-e7116a23736e
# ╟─4012087a-5915-44a2-84b0-261df092121f
# ╟─4d98c6a3-a063-4158-8e48-e5573ecffe7f
# ╟─98f3dd7d-e7d6-434c-9110-9d8d2f61954e
# ╟─08430e9e-f39e-4101-9d15-56df7d730358
# ╟─22ecbdff-a60e-4445-a2a1-aae5c90f090e
# ╟─96718528-a59d-41fd-be50-2e0f11e9ea45
