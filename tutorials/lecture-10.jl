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
	using PlutoExtras
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
# Lecture 10: 震源机制与破裂过程

!!! note "提纲"
	1. 震源机制解
	1. 震源破裂过程

"""

# ╔═╡ a40ec5ac-6c24-4f31-8576-970c6c819eb3
md"""
## 10.1 震源机制解
"""

# ╔═╡ bfaf98c2-eab6-4431-8b06-20ce0ea0e2ad
md"""
### P波初动
![](https://box.nju.edu.cn/f/f06439cbaf6947cd9302/?dl=1)
![](https://box.nju.edu.cn/f/f4429292ec2b49faa0df/?dl=1)
"""

# ╔═╡ 1e45960c-a66b-4afa-9404-ac9318d18de0
md"""
### 极射赤平投影

"""

# ╔═╡ 7a68c12d-6535-45a6-bba0-ed2b90075c92
TwoColumn(1/2,"center","center",
md"""
![](https://box.nju.edu.cn/f/1137c7dfce9e43909a57/?dl=1)

""",md"""
![](https://box.nju.edu.cn/f/d40b34405c2945588843/?dl=1)
""")

# ╔═╡ e38a0e81-95b4-42e1-a39c-0796bc354caf
md"""
![](https://box.nju.edu.cn/f/43ebce7c46fa49b2bf8c/?dl=1)
![](https://box.nju.edu.cn/f/5c0c0748e14b45e4aba2/?dl=1)
"""

# ╔═╡ f463c11c-3442-4153-b8b1-f28cc78e2719
md"""
### 震源机制解
![](https://box.nju.edu.cn/f/44ab3cd46f9b43549aaa/?dl=1)
"""

# ╔═╡ 67b4ddb5-c1fe-40e8-8191-0df997627e76
TwoColumn(1/2,"center","center",
md"""

![](https://box.nju.edu.cn/f/7e4093a69561496d830b/?dl=1)
""",md"""

![](https://box.nju.edu.cn/f/f33e8582ccab4bb78491/?dl=1)
""")

# ╔═╡ f122ad75-a821-4280-bdbc-68566e9e92fd
md"""
### gCAP震源机制解
![](https://box.nju.edu.cn/f/497e07e78282435481e9/?dl=1)
"""

# ╔═╡ 96541167-0882-40f3-a289-a86083a3994f
md"""
![](https://box.nju.edu.cn/f/607c6916622c4c88a9a8/?dl=1)
"""

# ╔═╡ 99b3a3d3-6c6a-4c9f-b5a6-6ded533ce928
TwoColumn(1/2,"center","center",
md"""
![](https://box.nju.edu.cn/f/acf581e2f27444219792/?dl=1)
![](https://box.nju.edu.cn/f/db3903040f4a4b2c863a/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/e8b77491939b433a80f5/?dl=1)
""")

# ╔═╡ 98275b5f-2dac-461b-88f2-f27b567d6411
md"""
### 典型构造的震源机制解
![](https://box.nju.edu.cn/f/8c39dc3d874245b28df1/?dl=1)
![](https://box.nju.edu.cn/f/d666f1f876ef49628a50/?dl=1)
![](https://box.nju.edu.cn/f/376c479c22c54183b04b/?dl=1)

#### Double seismic zone in NE Japan
![](https://box.nju.edu.cn/f/fe31404b995e4220b178/?dl=1)
![](https://box.nju.edu.cn/f/a4da5034bd5d45a1af03/?dl=1)
"""

# ╔═╡ c1254074-1fed-4c76-8b4a-edfb420a85d9
md"""
## 10.2 震源破裂过程

!!! tip "断层大小"
	* Mw 4: 长 1 km
	* Mw 7: 长 40 km
	* Mw 9: 长 1000 km
"""

# ╔═╡ 8cef448d-5b96-4f2b-bb62-6142ab783a14
TwoColumn(1/2,"center","center",
md"""
### 地震定位过程
![](https://box.nju.edu.cn/f/ab40ca224da04c1f80eb/?dl=1)

""",md"""

![](https://box.nju.edu.cn/f/5cd08c4230d64d1da50b/?dl=1)

""")

# ╔═╡ 8d9eb4c9-a0c8-4582-96b3-e7ea83ac583f
md"""
![](https://box.nju.edu.cn/f/8d014555e3df4ee2aca4/?dl=1)
![](https://box.nju.edu.cn/f/0f023029f35b486aae1e/?dl=1)
![](https://box.nju.edu.cn/f/f6270a6fca7e4af9b320/?dl=1)
"""

# ╔═╡ 1f067ff2-94b6-4386-8907-c56a3c595d31
md"""
### 有限断层反演

![](https://box.nju.edu.cn/f/ce6cfcf65e11478c8a8a/?dl=1)
"""

# ╔═╡ 9f4d7ed8-b289-4eea-ba25-8961585fa3ac
md"""
![](https://box.nju.edu.cn/f/a1d6a751a4ea449498ec/?dl=1)
"""

# ╔═╡ 9ee08a86-10c8-40b3-bd52-ca8943a6d3ee
md"""
![](https://box.nju.edu.cn/f/0470b87779ed4080b655/?dl=1)
"""

# ╔═╡ 7e91db39-156c-445d-8c2b-46add9f4b656
md"""
### 地震破裂反投影

![](https://box.nju.edu.cn/f/59228efe2b084b1daf76/?dl=1)

![](https://box.nju.edu.cn/f/6728a85b69564ae6b1b3/?dl=1)

![](https://box.nju.edu.cn/f/a7fa307a45ab4cd9a23a/?dl=1)

"""

# ╔═╡ 7b4c774a-204a-49ad-a972-2b0c92f7c064
TwoColumn(1/2,"center","center",
md"""
![](https://box.nju.edu.cn/f/2945bd27781142b89f8f/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/dd6f598cb64743d2aef1/?dl=1)
""")

# ╔═╡ b33d707e-2475-4f4a-a1b7-0d925d4f656d
TwoColumn(2/5,"center","center",
md"""
![](https://box.nju.edu.cn/f/54f2a7223c3147cb933b/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/8f30f83f30f34d00af27/?dl=1)
""")

# ╔═╡ 21f9c7a3-6193-4203-bbc9-2ceb74a88819
TwoColumn(2/5,"center","center",
md"""
![](https://box.nju.edu.cn/f/0470b87779ed4080b655/?dl=1)
""",md"""
![](https://box.nju.edu.cn/f/bcbe626804c24cf7a352/?dl=1)
""")


# ╔═╡ 219120ba-3d12-48ad-97b8-a30313a06ce1
md"""
## 10.x 思考题
* 绘制典型正断层、逆断层与走滑断层的震源机制解？
* 震源机制解指示了板块板片在俯冲过程中的应力状态发生了怎样的转变？
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
```math
\begin{equation} 
\tag{1.1}
\begin{split}

a &= \sum_{i=1}^{N} f(x) \mathtt{d} x \\
  &= 25x^2

\end{split}
\end{equation}
```

$$\begin{align}
\tag{1.1}
V_{sphere} = \frac{4}{3}\pi r^3
\end{align}$$

"""

# ╔═╡ e59fdd6b-ba1e-4557-a8a1-77411bc1d539
initialize_eqref()

# ╔═╡ 87f2ad9c-7d62-4891-a1c1-1f4a6300403b
md"""

$(texeq("
 2+3=5 \\\\
	x &= 1 \\\\
	  &= \\sum_2^N f(x) \\mathtt d x 
","align*"))

"""

# ╔═╡ 2cf044c7-c311-4cd4-bb07-63750a4145e0
md"""

$(texeq("
	x + y &= 6+4 \\label{my_label} \\\\  
	&= 10 \\label{another_label} \\\\  
	&= 10 \\label{another_label2} \\\\  
	&= 10 \\label{another_label3}
", "align"))
"""

# ╔═╡ d30fd7ea-58a0-49a8-8459-11274193f5f5
md"""

links to the same equation $(eqref("my_label")) but shouldn't $(eqref("another_label"))
"""

# ╔═╡ 41811963-3de1-4df7-b7e4-76991d80d7a1


# ╔═╡ Cell order:
# ╠═7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
# ╟─5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
# ╟─aaa0f3cc-f507-4f12-a611-0560fe8ecb24
# ╟─400ae1f1-4ee9-4f48-9fda-1f46918c452c
# ╟─6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
# ╟─08282040-eefc-4d50-b842-f2117e071f49
# ╟─d242187f-6179-49d1-a32a-1c750e173005
# ╟─3d4bfe36-bd67-4841-aaee-13c4537ef464
# ╟─a40ec5ac-6c24-4f31-8576-970c6c819eb3
# ╟─bfaf98c2-eab6-4431-8b06-20ce0ea0e2ad
# ╟─1e45960c-a66b-4afa-9404-ac9318d18de0
# ╟─7a68c12d-6535-45a6-bba0-ed2b90075c92
# ╟─e38a0e81-95b4-42e1-a39c-0796bc354caf
# ╟─f463c11c-3442-4153-b8b1-f28cc78e2719
# ╟─67b4ddb5-c1fe-40e8-8191-0df997627e76
# ╟─f122ad75-a821-4280-bdbc-68566e9e92fd
# ╟─96541167-0882-40f3-a289-a86083a3994f
# ╟─99b3a3d3-6c6a-4c9f-b5a6-6ded533ce928
# ╟─98275b5f-2dac-461b-88f2-f27b567d6411
# ╟─c1254074-1fed-4c76-8b4a-edfb420a85d9
# ╟─8cef448d-5b96-4f2b-bb62-6142ab783a14
# ╟─8d9eb4c9-a0c8-4582-96b3-e7ea83ac583f
# ╟─1f067ff2-94b6-4386-8907-c56a3c595d31
# ╟─9f4d7ed8-b289-4eea-ba25-8961585fa3ac
# ╟─9ee08a86-10c8-40b3-bd52-ca8943a6d3ee
# ╟─7e91db39-156c-445d-8c2b-46add9f4b656
# ╟─7b4c774a-204a-49ad-a972-2b0c92f7c064
# ╟─b33d707e-2475-4f4a-a1b7-0d925d4f656d
# ╟─21f9c7a3-6193-4203-bbc9-2ceb74a88819
# ╟─219120ba-3d12-48ad-97b8-a30313a06ce1
# ╟─757c3003-384b-4aee-8624-c59268d82b51
# ╟─236a9a53-03f4-4eb1-babd-5d1c4919a569
# ╠═3e87914e-de44-4e33-9624-8060e0796245
# ╠═e59fdd6b-ba1e-4557-a8a1-77411bc1d539
# ╠═87f2ad9c-7d62-4891-a1c1-1f4a6300403b
# ╠═2cf044c7-c311-4cd4-bb07-63750a4145e0
# ╠═d30fd7ea-58a0-49a8-8459-11274193f5f5
# ╠═41811963-3de1-4df7-b7e4-76991d80d7a1
