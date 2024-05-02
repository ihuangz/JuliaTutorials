### A Pluto.jl notebook ###
# v0.19.41

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
Lecture 8: 地震层析成像
===
!!! note "提纲"
	1. CT基础原理
	1. 地震波走时成像
	1. 全球层析成像模型	
	1. 地震波衰减成像
	1. 面波层析成像
	1. 全波形层析成像

"""

# ╔═╡ 924e1be8-7d2d-47bf-9f1a-bf69f73b8401
md"""
# 8.1 地震成像基本原理
"""

# ╔═╡ 2fe045cc-6473-4703-a9e8-d9eb5d824054
TwoColumn(0.6,"start","start",
md"""
![](https://box.nju.edu.cn/f/bf47e3d2efa44c09bded/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/e2608a174a41427baa72/?dl=1)
""")

# ╔═╡ 65154f06-a977-4de4-806e-3462cb73a48a
md"""

![](https://box.nju.edu.cn/f/b61ea0f0983a4f49a600/?dl=1)
"""

# ╔═╡ ed58d9fa-b6a1-4b6c-8acc-cd1b9d290cde
md"""
## 地震成像与电磁波谱
![](https://box.nju.edu.cn/f/67ac3b4426f74321aa74/?dl=1)
"""


# ╔═╡ 5efd19fb-eabc-49d9-963b-318111fb58e2
md"""
## 地震成像基本公式
![](https://box.nju.edu.cn/f/17f01e0f7eb74c0a8549/?dl=1)

地震反演使观测走时($t^{obs}$)与理论走时($t^{pre}$)间的走时残差($r$)最小。

$$t^{obs}=\int_{(s+\delta s)}\frac{ds}{c(s)+\delta c(s)}=\int_{(s+\delta s)}(u(s)+\delta u(s))\cdot ds$$

$$t^{pre}=\int_{s}\frac{ds}{c(s)}=\int_{s}u(s)\cdot ds$$

$$r=t^{obs}-t^{pre}$$

> 费马原理 (Fermat's Principal)：The travel time of a ray between two given points in space must be stationary for small perturbations in the path follow the ray.

结构异常会造成射线路径的偏移，但其对走时的影响可以忽略不计：

$$r=\int_{(s+\delta s)}(u(s)+\delta u(s))\cdot ds-\int_{s}u(s)\cdot ds$$

$$r=\int_{s}(u(s)+\delta u(s))\cdot ds-\int_{s}u(s)\cdot ds$$

$$r=\int_{s}(u(s)+\delta u(s)-u(s))\cdot ds=\int_{s}\delta u(s)\cdot ds$$

$$r=\int_{s}\delta u\cdot ds=\int_{s}\delta(\frac{1}{v})\cdot ds=-\int_{s}\frac{\delta v}{v^{2}}\cdot ds=-\int_{s}\frac{\delta v}{v}\cdot dt$$

$$r=\frac{\partial T}{\partial\lambda}\cdot\Delta\lambda+\frac{\partial T}{\partial\varphi}\cdot\Delta\varphi+\frac{\partial T}{\partial h}\cdot\Delta h+\frac{\partial T}{\partial t}\cdot\Delta t+\sum_{1}^{N}\frac{\partial T}{\partial u}\cdot\Delta u+\mathbf{e}$$
"""


# ╔═╡ 6f2bcb3b-a0e2-4ae9-ace6-51f4299fc0a8
md"""

!!! note "地震层析成像一般步骤"
	* 地震定位
	* 射线追踪
	* 建立方程组
	* 求解方程组
	* 分辨率测试与误差分析

## 地震成像可信度评估
![](https://box.nju.edu.cn/f/15d2007225de4158bfc5/?dl=1)


"""

# ╔═╡ 06e011fe-3472-4c13-8264-b08a65f99199
md"""
## 面波层析成像
"""

# ╔═╡ 438e25ae-cb03-42c9-8098-a2058618d779
TwoColumn(1/3,"start","start",
md"""
![](https://box.nju.edu.cn/f/63c872f01b7342e6894b/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/5d78508b19434ddfa536/?dl=1)
""")

# ╔═╡ ca65b957-e2ef-418e-bfe8-ccc97108436f
md"""
![](https://box.nju.edu.cn/f/e1eaed8f089848b0a0e3/?dl=1)
"""

# ╔═╡ 76a73911-61fb-47c7-9ed3-38862f708eee
TwoColumn(0.5,"start","start",
md"""
![](https://box.nju.edu.cn/f/8282f4586db145f09664/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/c82fefb574804893b7db/?dl=1)
""")

# ╔═╡ 9b5f49a9-8f9e-49de-abc0-25456c785dac
md"""
#### 台站间频散曲线 $\Rightarrow$ 2D相速度分布图  $\Rightarrow$ 三维Vs分布图 
"""

# ╔═╡ 58e7a4dc-0ee2-4033-92ac-b50448003304
TwoColumn(1/2,"center","center",
md"""
#### 体波反演： 50 km
![](https://box.nju.edu.cn/f/2c7014b629bf4429bb12/?dl=1)
""",md"""
---
#### 面波反演： 100 km
![](https://box.nju.edu.cn/f/427effb472df4fbda636/?dl=1)
""")

# ╔═╡ 2839796d-6e25-42ee-acc5-f666f86addba
md"""
# 8.2 地震成像经典结果
"""

# ╔═╡ 8e62ba77-aa82-413a-907f-2332c23c60e3
md"""
## 人工地震层析成像
![](https://box.nju.edu.cn/f/f6fb482e0b7f41ceaaa8/?dl=1)
![](https://box.nju.edu.cn/f/92c76d044cfd4913b575/?dl=1)
![](https://box.nju.edu.cn/f/72f5a2129c584ebeadd6/?dl=1)
"""

# ╔═╡ 226606f8-ddb0-406f-bfb1-1742c5653ea8
md"""
## 俯冲带层析成像
"""

# ╔═╡ 1503c81d-e2d9-431c-a1fe-bff52938c3d2
TwoColumn(1/2,"start","start",
md"""
![](https://box.nju.edu.cn/f/620d0b8b30b24d748f52/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/cde34dee450248e39322/?dl=1)
""")

# ╔═╡ 769a400e-94f1-425d-b442-889fc37c860a
md"""
### 板块俯冲与岛弧火山
"""

# ╔═╡ 3eb6289f-67b8-4950-b43b-aded87e1bf1d
md"""
![](https://box.nju.edu.cn/f/0059ad600c1c46ffbd41/?dl=1)
![](https://box.nju.edu.cn/f/a909e2db98a2486faf54/?dl=1)
"""

# ╔═╡ b9160a1e-736b-421f-b1ec-183bd644b3ac
md"""
### 板间巨大地震成因
"""

# ╔═╡ 23407cdc-693b-4aa5-92ed-22dcb19840d3
md"""
![](https://box.nju.edu.cn/f/00e5287e7dfe4580b7ef/?dl=1)
"""

# ╔═╡ cf2d0e52-aed0-4a5c-8a80-fe908d13d7fa
md"""
### 板块深俯冲
"""

# ╔═╡ 23eeb535-b330-49f4-8a35-fd719f13b763
md"""
![](https://box.nju.edu.cn/f/28c1a76e7d664cad8b44/?dl=1)
"""

# ╔═╡ aa991901-7824-4a30-985c-e7c519f47639
TwoColumn(0.66,"start","center",
md"""
![](https://box.nju.edu.cn/f/33d1790587cd46539cd4/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/c8e18909fa8b42e399bc/?dl=1)
#### Slab graveyard
![](https://box.nju.edu.cn/f/05dabbd6cfc44645bd98/?dl=1)
""")

# ╔═╡ d38916e5-cc1b-41a1-87cf-9cde2220e85a
md"""
## 全球板片分布
![](https://box.nju.edu.cn/f/929dc584dee2498da190/?dl=1)
![](https://box.nju.edu.cn/f/b4fae145355f401891fe/?dl=1)
"""

# ╔═╡ ab3c962a-3902-4883-ba1a-c30298d66251
md"""
## 全球热点火山

![](https://box.nju.edu.cn/f/0175d47f7fd14f858c09/?dl=1)

### 黄石公园火山
![](https://box.nju.edu.cn/f/67fe355a35164a328ec0/?dl=1)

### 夏威夷火山
![](https://box.nju.edu.cn/f/14b1e8c54d71492d80b2/?dl=1)

### 长白山火山
![](https://box.nju.edu.cn/f/0f2b61615c4344289ff3/?dl=1)

"""

# ╔═╡ bb055847-3ebc-4cf9-818e-f5c4a8012d29
md"""
## LLSVP

### 地幔底部S波速度
![](https://box.nju.edu.cn/f/8bddc599f03f444f8b28/?dl=1)

### 地球“肿瘤”
![](https://box.nju.edu.cn/f/2ae2b5441d9a46f0ad2d/?dl=1)

### LLSVP成因新解
![](https://box.nju.edu.cn/f/267727a2f6a648448e94/?dl=1)

"""

# ╔═╡ 03f5a986-5ab8-4dfc-a3f1-9ba06afe42b6
md"""
# 8.5 层析成像最新进展
"""

# ╔═╡ e036dcd7-631b-454c-9fc8-ad2d025d8ddd
md"""
## 有限频层析成像
![](https://box.nju.edu.cn/f/5c4638dbc4b849caa0b3/?dl=1)
"""

# ╔═╡ 301e2efe-1339-46e7-a15d-cdb352f78c08
md"""

## 噪声面波成像
![](https://box.nju.edu.cn/f/5e567807e8724ad3a2c8/?dl=1)
![](https://box.nju.edu.cn/f/9e0cbea70d6744738cf3/?dl=1)
"""

# ╔═╡ 67ab45d2-7509-49a2-842f-547bc69a763c
md"""
## 全波形层析成像
"""

# ╔═╡ d0820dd9-e00c-46af-bc82-6f2cd77dfd50
md"""
### 走时拟合 vs 波形拟合
![](https://box.nju.edu.cn/f/508deddb67464f72a6de/?dl=1)
"""

# ╔═╡ e88ae3ea-68d4-4f9f-9689-372046f95769
TwoColumn(1/2,"center","center",
md"""
#### 远震地震波敏感核
![](https://box.nju.edu.cn/f/2f119029507d4fa09f76/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/e07797611b7b4216b81c/?dl=1)
""")


# ╔═╡ d39d64e1-6dff-42fb-8823-952a85e9accc
md"""
### 不同方法俯冲板片图像对比
"""

# ╔═╡ 80706f81-da60-49c7-80f3-5c23035b0208
TwoColumn(1/2,"center","center",
md"""
###### 走时层析成像
""",md"""
###### 有限频（上）与全波形（下）层析成像
""")

# ╔═╡ d98e2ab9-5134-43fe-ad51-7c6ce376fcf8
md"""
![](https://box.nju.edu.cn/f/c04ebf3b64964cafabf4/?dl=1)
"""

# ╔═╡ 219120ba-3d12-48ad-97b8-a30313a06ce1
md"""
# 8.x 思考题
* 地震波走时/有限频/全波形层析成像的内涵有哪些差异？
* 与地震波反射/折射研究相比，地震层析成像的优缺点有哪些？
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
# ╠═6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
# ╟─08282040-eefc-4d50-b842-f2117e071f49
# ╟─d242187f-6179-49d1-a32a-1c750e173005
# ╟─3d4bfe36-bd67-4841-aaee-13c4537ef464
# ╟─924e1be8-7d2d-47bf-9f1a-bf69f73b8401
# ╟─2fe045cc-6473-4703-a9e8-d9eb5d824054
# ╟─65154f06-a977-4de4-806e-3462cb73a48a
# ╟─ed58d9fa-b6a1-4b6c-8acc-cd1b9d290cde
# ╟─5efd19fb-eabc-49d9-963b-318111fb58e2
# ╟─6f2bcb3b-a0e2-4ae9-ace6-51f4299fc0a8
# ╟─06e011fe-3472-4c13-8264-b08a65f99199
# ╟─438e25ae-cb03-42c9-8098-a2058618d779
# ╟─ca65b957-e2ef-418e-bfe8-ccc97108436f
# ╟─76a73911-61fb-47c7-9ed3-38862f708eee
# ╟─9b5f49a9-8f9e-49de-abc0-25456c785dac
# ╟─58e7a4dc-0ee2-4033-92ac-b50448003304
# ╟─2839796d-6e25-42ee-acc5-f666f86addba
# ╟─8e62ba77-aa82-413a-907f-2332c23c60e3
# ╟─226606f8-ddb0-406f-bfb1-1742c5653ea8
# ╟─1503c81d-e2d9-431c-a1fe-bff52938c3d2
# ╟─769a400e-94f1-425d-b442-889fc37c860a
# ╟─3eb6289f-67b8-4950-b43b-aded87e1bf1d
# ╟─b9160a1e-736b-421f-b1ec-183bd644b3ac
# ╟─23407cdc-693b-4aa5-92ed-22dcb19840d3
# ╟─cf2d0e52-aed0-4a5c-8a80-fe908d13d7fa
# ╟─23eeb535-b330-49f4-8a35-fd719f13b763
# ╟─aa991901-7824-4a30-985c-e7c519f47639
# ╟─d38916e5-cc1b-41a1-87cf-9cde2220e85a
# ╟─ab3c962a-3902-4883-ba1a-c30298d66251
# ╟─bb055847-3ebc-4cf9-818e-f5c4a8012d29
# ╟─03f5a986-5ab8-4dfc-a3f1-9ba06afe42b6
# ╟─e036dcd7-631b-454c-9fc8-ad2d025d8ddd
# ╟─301e2efe-1339-46e7-a15d-cdb352f78c08
# ╟─67ab45d2-7509-49a2-842f-547bc69a763c
# ╟─d0820dd9-e00c-46af-bc82-6f2cd77dfd50
# ╟─e88ae3ea-68d4-4f9f-9689-372046f95769
# ╟─d39d64e1-6dff-42fb-8823-952a85e9accc
# ╟─80706f81-da60-49c7-80f3-5c23035b0208
# ╟─d98e2ab9-5134-43fe-ad51-7c6ce376fcf8
# ╟─219120ba-3d12-48ad-97b8-a30313a06ce1
# ╟─757c3003-384b-4aee-8624-c59268d82b51
# ╟─236a9a53-03f4-4eb1-babd-5d1c4919a569
