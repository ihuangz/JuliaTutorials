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
Lecture 9: 地震各向异性
===
!!! note "提纲"
	1. 矿物与岩石各向异性
	1. 地震波各向异性

![](https://box.nju.edu.cn/f/73bc0240bad94391a4e4/?dl=1)
"""

# ╔═╡ 924e1be8-7d2d-47bf-9f1a-bf69f73b8401
md"""
# 9.1 矿物与岩石各向异性

## 矿物各向异性

![](https://box.nju.edu.cn/f/ae3e114ca65e435cb578/?dl=1)
"""

# ╔═╡ 9001a8e4-74df-435a-ab48-550e12d071c4
TwoColumn(1/2,"center","center",
md"""
#### 下半球赤平投影
![](https://box.nju.edu.cn/f/1137c7dfce9e43909a57/?dl=1)
""",md"""
#### 沃尔夫网
![](https://box.nju.edu.cn/f/d40b34405c2945588843/?dl=1)
""")

# ╔═╡ d2d4fd66-aefb-4e9b-985f-aab2c249e0e9
md"""
### 上地幔矿物（橄榄石/顽辉石/透辉石）
![](https://box.nju.edu.cn/f/09684f5df94c42c0948a/?dl=1)
"""

# ╔═╡ e55fbfaa-d8b8-428b-af0d-2f034b33bd59
md"""
### 转换带矿物（瓦兹利石/林伍德石）
![](https://box.nju.edu.cn/f/aa8688773eb34d049971/?dl=1)
"""

# ╔═╡ 6eb4f595-4251-45d4-bea8-fb042e28aa2c
md"""
### 下地幔矿物（Mg-钙钛矿）
![](https://box.nju.edu.cn/f/8b3ec6962fbc435ebeb6/?dl=1)

### 下地幔底部矿物（后钙钛矿）
![](https://box.nju.edu.cn/f/1bbbba172f0b4ed5b91a/?dl=1)
"""

# ╔═╡ 634ac3a2-299c-43e6-93e5-9f8cc0e7bdd0
md"""
### 地幔矿物各向异性
"""

# ╔═╡ 983748bc-401d-48af-9b1f-0cf2d2e583ee
TwoColumn(1/2,"center","center",
md"""
![](https://box.nju.edu.cn/f/5228581f5b244d90ab9b/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/2b049abdcb6b42a39a53/?dl=1)
""")

# ╔═╡ 0fa0502b-a28b-4f17-8ccb-82dbaf275ead
md"""
## 岩石各向异性

"""

# ╔═╡ e121e3f7-4214-4170-bc90-37b106d12b68
TwoColumn(1/2,"center","center",
md"""
#### 地幔演化
![](https://box.nju.edu.cn/f/73bc0240bad94391a4e4/?dl=1)
""",md"""
#### 岩石变形
![](https://box.nju.edu.cn/f/b1048d9013334f928ebb/?dl=1)
""")

# ╔═╡ acb1b96e-e850-4077-9ecb-76729920dbe5
md"""

$$\LARGE\color{red}矿物晶体在应力的作用定向排列$$
![](https://box.nju.edu.cn/f/c0e97a3f415e4617a24a/?dl=1)
"""

# ╔═╡ 9dc6f035-8f3b-4ea8-9c55-7f105172050c
md"""
$$\LARGE\color{blue}矿物各向异性 \Rightarrow 岩石各向异性$$
![](https://box.nju.edu.cn/f/8e6c250d3bc04c2cb118/?dl=1)

"""

# ╔═╡ 104a8f83-7dbb-42d3-a84a-26ec30425f1d
md"""
### 晶体定向排列
![](https://box.nju.edu.cn/f/aa152651bd354432a2ee/?dl=1)
"""

# ╔═╡ ae751a75-6268-4b7e-8cc9-e70b2437f4eb
md"""
#### 橄榄石定向排列
![](https://box.nju.edu.cn/f/5f559a76563443cf8779/?dl=1)
#### 橄榄石岩石各向异性
![](https://box.nju.edu.cn/f/0b41636565f747d1b19a/?dl=1)
"""

# ╔═╡ 851a0cea-637e-4909-8e32-ad070ed24765
md"""
### 形状定向排列
![](https://box.nju.edu.cn/f/b7a220f1ab4546b489ce/?dl=1)

#### 部分熔融体
![](https://box.nju.edu.cn/f/1213655873964c719f4f/?dl=1)
"""

# ╔═╡ aeccde3c-ac0c-4857-ad7a-990b8d5f0bda
TwoColumn(1/2,"center","center",
md"""
#### 微裂隙
![](https://box.nju.edu.cn/f/3d8ca7f318614524a685/?dl=1)
""",md"""
#### 断层
![](https://box.nju.edu.cn/f/81fddadecb9148d789d9/?dl=1)
""")

# ╔═╡ 547fc5ad-e442-47aa-b673-0bb5624ad2ab
md"""
# 9.2 地震波各向异性
![](https://box.nju.edu.cn/f/73bc0240bad94391a4e4/?dl=1)
"""

# ╔═╡ a0605ffb-b75f-4cc2-b81f-ed72146ee474
TwoColumn(1/2,"center","center",
md"""
![](https://box.nju.edu.cn/f/b1048d9013334f928ebb/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/ef67d6c836364bf7b8ca/?dl=1)
""")

# ╔═╡ d588fbaf-976d-45a3-aa1e-3291830feb58
md"""
## 地震学观测
"""

# ╔═╡ 2fbec0ea-bd45-43c5-be0e-9db352b2fa64
TwoColumn(1/2,"center","center",
md"""
#### 太平洋盆
![](https://box.nju.edu.cn/f/64ca9ea64b534b81a637/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/8460f9040315471f869a/?dl=1)
""")

# ╔═╡ e82d43ce-59a4-40d2-93d5-60d89005efb6
md"""
![](https://box.nju.edu.cn/f/71f63ba81502407b961c/?dl=1)
"""

# ╔═╡ 4ccfb7f4-d34c-4eaa-9d91-b8488d107ae8
md"""
!!! note "各向异性研究方法"
	* 剪切波分裂
	* 各向异性层析成像
"""

# ╔═╡ 9df369a2-77e8-4f78-aee1-4fb1acac2bab
md"""
## 剪切波分裂
#### Shear wave splitting
"""

# ╔═╡ b05c7d03-7cac-4b81-9ae4-9975912d8bd8
TwoColumn(1/2,"center","center",
md"""
#### 
![](https://box.nju.edu.cn/f/acdba917ae25406b9cee/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/4893e66966454798a98f/?dl=1)
""")

# ╔═╡ 324ad92c-eda4-42a3-9086-007cdafa0c80
md"""
$$\LARGE\color{red}剪切波分裂参数：快轴偏振方向/快慢波时间差$$
![](https://box.nju.edu.cn/f/c72fe80b415649d1a9da/?dl=1)
![](https://box.nju.edu.cn/f/447803b9a6f945ac903c/?dl=1)
![](https://box.nju.edu.cn/f/57e430432b5e46209853/?dl=1)
"""

# ╔═╡ 8645bcb0-c8ec-43c4-9af8-9a2a8cb8760c
md"""
![](https://box.nju.edu.cn/f/6a49f1db5fac4e1f9139/?dl=1)
"""

# ╔═╡ 8622b799-9ed4-405e-896b-141213f9334e
TwoColumn(1/2,"center","center",
md"""
#### 
![](https://box.nju.edu.cn/f/87f0702b4912473292d5/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/30248014c4e546328bb8/?dl=1)
![](https://box.nju.edu.cn/f/209e184d7be54c239796/?dl=1)
""")

# ╔═╡ 2047a334-15aa-4332-b5ee-8f7e0ae83feb
md"""
## 各向异性成像
"""

# ╔═╡ 26f8bc22-3e26-4929-9a51-96aa69c518be
TwoColumn(1/2,"center","center",
md"""

![](https://box.nju.edu.cn/f/8460f9040315471f869a/?dl=1)
""",md"""
$$v(\theta)=v_0+M\cdot \cos 2\theta $$

$$v(\theta)= v_0 + A\cos 2\phi + B\sin 2\phi$$

$$\mathbf{r}=\frac{\partial T}{\partial H}\Delta H + \frac{\partial T}{\partial V}\Delta V$$

$$\mathbf{\ }\color{red}+\frac{\partial T}{\partial A}\Delta A + \frac{\partial T}{\partial B}\Delta B$$

各向异性强度$\alpha(A,B)$与快波方向$\Phi(A,B)$

""")

# ╔═╡ 54fd9927-12f5-4015-b308-d33fd9d42aca
TwoColumn(0.43,"center","center",
md"""

![](https://box.nju.edu.cn/f/5ba5a2b9bab9488aa3e1/?dl=1)
""",md"""

![](https://box.nju.edu.cn/f/c91ec84f16a3464ca7e9/?dl=1)

""")

# ╔═╡ 07be1099-d6c3-4450-a18c-965b3b5b76cf
md"""
![](https://box.nju.edu.cn/f/90667ae4fc504e3092cd/?dl=1)
"""

# ╔═╡ 39b5af96-e285-4700-a4a8-75cd3627e3a6
md"""
![](https://box.nju.edu.cn/f/0de5982a315944ef95b3/?dl=1)
"""

# ╔═╡ d40f52cc-88ce-47d6-b45b-9a5cedb34561
md"""
![](https://box.nju.edu.cn/f/017157f3d82a4b24bf39/?dl=1)
"""

# ╔═╡ f5f25034-cde3-4b78-a4cb-91a38f266ee1
md"""
![](https://box.nju.edu.cn/f/8c349878922d4b838bb8/?dl=1)
![](https://box.nju.edu.cn/f/2bba9092e0924e7fb21d/?dl=1)
"""

# ╔═╡ e91d5796-7322-44a4-91d3-a353f2447752
md"""
## 径向各向异性
"""

# ╔═╡ 3a1ab2c0-7690-4291-ba88-c72aa7ffd036
md"""
![](https://box.nju.edu.cn/f/b4be1ec948a14d0a925a/?dl=1)
![](https://box.nju.edu.cn/f/b2720726c92945ac811d/?dl=1)
![](https://box.nju.edu.cn/f/d540bd62cbe64855ba28/?dl=1)
"""

# ╔═╡ 219120ba-3d12-48ad-97b8-a30313a06ce1
md"""
# 9.x 思考题
* 各向异性相比于其他地震学研究方法，能够额外揭示哪些地球内部结构与演化的信息？
* 从变形与各向异性的关系推断，俯冲带、洋中脊、造山带、裂谷带等典型构造区，其各向异性有什么特点？
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

# ╔═╡ 3e87914e-de44-4e33-9624-8060e0796245
md"""

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
# ╟─9001a8e4-74df-435a-ab48-550e12d071c4
# ╟─d2d4fd66-aefb-4e9b-985f-aab2c249e0e9
# ╟─e55fbfaa-d8b8-428b-af0d-2f034b33bd59
# ╟─6eb4f595-4251-45d4-bea8-fb042e28aa2c
# ╟─634ac3a2-299c-43e6-93e5-9f8cc0e7bdd0
# ╟─983748bc-401d-48af-9b1f-0cf2d2e583ee
# ╟─0fa0502b-a28b-4f17-8ccb-82dbaf275ead
# ╟─e121e3f7-4214-4170-bc90-37b106d12b68
# ╟─acb1b96e-e850-4077-9ecb-76729920dbe5
# ╟─9dc6f035-8f3b-4ea8-9c55-7f105172050c
# ╟─104a8f83-7dbb-42d3-a84a-26ec30425f1d
# ╟─ae751a75-6268-4b7e-8cc9-e70b2437f4eb
# ╟─851a0cea-637e-4909-8e32-ad070ed24765
# ╟─aeccde3c-ac0c-4857-ad7a-990b8d5f0bda
# ╟─547fc5ad-e442-47aa-b673-0bb5624ad2ab
# ╟─a0605ffb-b75f-4cc2-b81f-ed72146ee474
# ╟─d588fbaf-976d-45a3-aa1e-3291830feb58
# ╟─2fbec0ea-bd45-43c5-be0e-9db352b2fa64
# ╟─e82d43ce-59a4-40d2-93d5-60d89005efb6
# ╟─4ccfb7f4-d34c-4eaa-9d91-b8488d107ae8
# ╟─9df369a2-77e8-4f78-aee1-4fb1acac2bab
# ╟─b05c7d03-7cac-4b81-9ae4-9975912d8bd8
# ╟─324ad92c-eda4-42a3-9086-007cdafa0c80
# ╟─8645bcb0-c8ec-43c4-9af8-9a2a8cb8760c
# ╟─8622b799-9ed4-405e-896b-141213f9334e
# ╟─2047a334-15aa-4332-b5ee-8f7e0ae83feb
# ╟─26f8bc22-3e26-4929-9a51-96aa69c518be
# ╟─54fd9927-12f5-4015-b308-d33fd9d42aca
# ╟─07be1099-d6c3-4450-a18c-965b3b5b76cf
# ╟─39b5af96-e285-4700-a4a8-75cd3627e3a6
# ╟─d40f52cc-88ce-47d6-b45b-9a5cedb34561
# ╟─f5f25034-cde3-4b78-a4cb-91a38f266ee1
# ╟─e91d5796-7322-44a4-91d3-a353f2447752
# ╟─3a1ab2c0-7690-4291-ba88-c72aa7ffd036
# ╟─219120ba-3d12-48ad-97b8-a30313a06ce1
# ╟─757c3003-384b-4aee-8624-c59268d82b51
# ╟─236a9a53-03f4-4eb1-babd-5d1c4919a569
# ╠═3e87914e-de44-4e33-9624-8060e0796245
