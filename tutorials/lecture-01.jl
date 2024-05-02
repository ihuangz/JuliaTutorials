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

# ╔═╡ 8b453253-b6ce-4cd1-a8b4-f0ddb9fb1656
md"""
# Lecture 1: 地震分布

!!! note "提纲"
	* 地震参数: 时间、位置、大小、...
	* 地震分布规律: 类型、特点、...
	* 地震灾害与预防: 预报、预警、...
 
"""

# ╔═╡ 9aae3fdf-1099-4c95-9fc0-7c3ce5fe7960
md"""
## 1.1 地震参数
"""

# ╔═╡ 78e2e603-77f0-4c30-ba9b-30f62e023b53
TwoColumn(md"""
!!! note "地震五参数"
	* 经度
	* 纬度
	* 震源深度
	* 发震时刻
	* 震级
!!! tip "其他参数"
	* 震中: 经度+纬度
	* 震中距: 公里 / 度
	* 烈度: 地表破坏程度
""", html"""
<p style="display: flex; flex-direction: column; align-items:center; transform: translateY(30%)">
<img src="https://box.nju.edu.cn/f/f77ac886d5724e6e856a/?dl=1" height="200" style="margin:auto">
<strong>Focus of an earthquake</strong> 

</p>

""")

# ╔═╡ 38f7fc71-02c3-466e-9aee-706acca57daf
md"""

## 1.1 地震参数: 震中
"""

# ╔═╡ 215ed80f-00c9-4f1e-bba8-5bf2a20a063e
html"""
<p style="display: flex; flex-direction: column; align-items:center; transform: translateY(%)">

<strong><font size="4" color="red">走时曲线</font></strong> 

<img src="https://box.nju.edu.cn/f/ab40ca224da04c1f80eb/?dl=1" height="300" style="margin:auto">
<img src="https://box.nju.edu.cn/f/5cd08c4230d64d1da50b/?dl=1" height="250" style="margin:auto">
</p>
"""

# ╔═╡ a7c61f18-1a16-40dc-8c8a-e828e36d7404
md"""
!!! note "地震定位"
	- 震中距与地震波走时(差)成正比
	- 三圆交点可以唯一确定震中位置
	- 一般浅震的震源深度难以确定
	- 发震时刻与震源深度耦合较强

"""

# ╔═╡ 3f97fee8-1c72-4339-983f-cb4d5acecf84
md"""
## 1.1 地震参数: 震级
"""

# ╔═╡ f0a13b7c-f714-47eb-9d19-0989aace349a
TwoColumn(
md"""
\
\

![](https://box.nju.edu.cn/f/8d014555e3df4ee2aca4/?dl=1)
!!! note "震级确定"
	* 测量震幅
	* 仪器校准
	* 计算震级
!!! tip "震级类型"
	* 近震震级
	* 体波震级
	* 面波震级
	* 矩震级
""",md"""
![](https://box.nju.edu.cn/f/f17cf300d73947f0a7da/?dl=1)
计算公式: $M=\log_{10}(\frac{A}{T})+q(\Delta, h)+a$
* 近震震级(里氏震级)
$M_L=\log_{10}A-\log_{10}A_{100\ km}$
$M_L=\log_{10}A+2.56\log_{10}\Delta-1.67$
* 体波震级
$m_b=\log_{10}(\frac{A}{12}) + 0.01\Delta + 5.9$
* 面波震级
$M_S=\log_{10}(\frac{A}{T})_{max} + 1.66 \log_{10}\Delta+3.3$

"""
)

# ╔═╡ 8e1111d8-3324-4f32-ad7a-35d4e02e2fc1
md"""

$m_b=\log_{10}(\frac{A}{T}) + Q(h,\Delta)$
$m_B=\log_{10}(\frac{A}{12}) + Q(h,\Delta)$


$M_S=\log_{10}A_{20} + 1.66 \log_{10}\Delta+2.0$


$\log_{10}E_R\approx 4.8+1.5M_S$
"""



# ╔═╡ 3081669b-f7e5-449e-a9c3-829372ddcb9d
md"""
## 1.1 地震参数: 震级
"""

# ╔═╡ 8063ff42-f205-47ac-b4ce-7e524a206fe3
TwoColumn(
md"""

#### 地震震级饱和
![](https://box.nju.edu.cn/f/974a00eb83b843efb4d0/?dl=1)

""",
md"""

#### 地震距与距震级
* 地震矩
$M_0=\mu DS$

* 矩震级
$M_W=\frac{2}{3}[\log_{10}M_0-9.1]$

| 日期 | 震中 |  $m_b$ |  $M_S$ |  $M_W$ | 
| --- | --- |  --- |  --- |  --- | 
| 1960.5.22| Chile |    |  8.3 |  9.5 | 
| 1964.3.28| Alaska |    |  8.4 |  9.2 | 
| 2004.12.26| Sumatra |  6.2  |  8.5 |  9.1 | 
| 1957.3.9| Aleutian |    |  8.2 |  9.1 | 
| 2011.3.11| Japan |  7.2  |  8.3 |  9.1 | 
| 2010.2.27| Chile |  7.2  |  8.5 |  8.8 | 
| 2008.5.12| China |  6.9  |  8.0 |  7.9 | 
"""
)

# ╔═╡ 96f2c4be-a69a-4ed4-b3ab-2f375b14b233
md"""
## 1.1 地震参数: 震级 vs 烈度

!!! tip "震级"
	* 对地震大小的绝对表述, 唯一的, 不受观测条件的影响
	* 地震的能量$\log_{10}E=4.8+1.5M_S$
	* 体波震级: $\log_{10}E=-1.2+2.4m_b$
!!! note "烈度"
	地表破坏的表述, 受震源深度/震中距/场地条件等因素的影响
![](https://box.nju.edu.cn/f/de614471572149debdfa/?dl=1)


"""

# ╔═╡ 647c2323-6548-40b5-8fe5-a0d7019bbfd4


# ╔═╡ 6167a1ad-59ff-47d8-a2f9-c86c0439bb19
md"""
## 1.2 地震分布规律: 分类
!!! note "触发类型"
	* 天然地震: 构造地震, 火山地震
	* 诱发地震: 水库地震, 石油/天然气开采诱发地震
!!! note "地震大小"
	* 无感地震: $M\le3级$
	* 小地震:  $3<M\le5级$
	* 中强地震: $5<M\le7级$
	* 大地震: $M>7级$
!!! note "震源深度"
	* 浅源地震: $h\le60\ km$
	* 中源地震: $60\ <h\le300\ km$
	* 深源地震: $h>300\ km$
!!! note "震中距"
	* 地方震: $\Delta\le100\ km$
	* 近震: $100\ km<\Delta\le1000\ km$
	* 远震: $\Delta>1000\ km$
"""

# ╔═╡ 1886f233-56d0-4984-a146-bfcad55a79da
md"""
## 1.2 地震分布规律: 地点

![](https://box.nju.edu.cn/f/6603875b72ca4722a3b4/?dl=1)
!!! note "环太平洋地震带"
	* 地震多, 震级大, 以逆冲和走滑型为主
	* 全球80%以上地震, 4/5 9级以上地震, 1962 智利$M_W 9.5$地震
!!! note "欧亚地震带:地中海-喜马拉雅-印度尼西亚地震带"
	* 陆内地震多, 地震破坏大
	* 全球15%的地震, 与人类文明如影相随
!!! note "洋中脊地震带"
	* 震级小, 远离陆地, 破坏不大
!!! tip "陆内地震带"
	* 大陆裂谷, 陆内变形/造山带
"""

# ╔═╡ 8f35f70c-5638-4fa7-8051-a9be0b7c971e
TwoColumn(
md"""
#### 和达-贝尼奥夫带 (Wadachi-Benioff seismic zone)
* 中深源地震分布带
* 最大深度达751 km (2015 Bonin 地震 $M_W 7.9$余震: 681 km)
* 最大的深源地震: $M_W8.3$, 609 km (2013 鄂霍茨克海)
""",
md"""
![](https://box.nju.edu.cn/f/2b05ad10e83f464181da/?dl=1)
"""
	
)

# ╔═╡ 26ed490b-8aba-41e6-a23e-f731ec0af022
md"""
## 1.2 地震分布规律: 地震 vs 板块构造

"""

# ╔═╡ 5bfa31eb-17d4-4458-b36c-b183669eb0fe
html"""
<p style="display: flex; flex-direction: column; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/620d0b8b30b24d748f52/?dl=1" width=600>
<img src="https://box.nju.edu.cn/f/c1f3563c07ef437e9bab/?dl=1" width=600>
</p>
"""

# ╔═╡ 9c7b180a-b295-46f6-8e18-cf244441cfb6
md"""
## 1.2 地震分布规律: 诱发地震
![](https://box.nju.edu.cn/f/55ce5587c2444ea7a7e8/?dl=1)
"""

# ╔═╡ 8d902032-e100-4241-8bc0-ee97ffadd8ea
TwoColumn(
md"""
!!! warning "工业开采"

![](https://box.nju.edu.cn/f/8eefbc04e8bc4176a542/?dl=1)
""",

md"""
!!! warning "工业开采"
	* 2023.4.27 扬州$M3.1$地震
	* 2019.6.17 四川长宁$M6.0$地震

!!! danger "水库地震"
	* 1962年,中国新丰江水库地震, $M6.1$
	* 1963年,赞比亚-津巴布韦卡里马水库地震, $M6.3$
	* 1966年,希腊克里玛斯塔水库地震, $M6.3$
	* 1967年,印度科依纳水库地震, $M6.5$
"""
)

# ╔═╡ b9dd8fcf-b74e-46bf-b0ba-00340dcaf3c2
md"""
## 1.2 地震分布规律: 频次
![](https://box.nju.edu.cn/f/d467cdcc06024d08a15e/?dl=1)
"""

# ╔═╡ 7dffd754-d5b4-4a28-93bd-f3fdda033b0d
TwoColumn(
html"""
<img src="https://box.nju.edu.cn/f/2856ba74b20348d482fb/?dl=1" height=200>
""",
html"""
<img src="https://box.nju.edu.cn/f/f3f812a50cc94ac48d1f/?dl=1" height=200>
"""

	
)

# ╔═╡ 735758f6-0307-4528-95d8-968e1d040b31
md"""
## 1.3 地震灾害与预防: 全球
**联合国《灾害造成的人类损失2000-2019》报告**: 自然灾害致死人数
![](https://box.nju.edu.cn/f/e3297efc3c0f4e38bc15/?dl=1)
![](https://box.nju.edu.cn/f/d037441f402b4d869ff0/?dl=1)
"""

# ╔═╡ e72fd12b-9cef-43a5-85fc-2f7d72a850a1
md"""
## 1.3 地震灾害与预防: 中国
![](https://box.nju.edu.cn/f/addb3cc5802b459cad70/?dl=1)
"""

# ╔═╡ eecfe714-afa1-4336-88c2-00685388093e
html"""
<p style="display: flex; justify-content: center; align-items: center">
<img src="https://box.nju.edu.cn/f/6b6174feb76c45cd84f4/?dl=1", width=420>
<img src="https://box.nju.edu.cn/f/70903cbbd31745ebb272/?dl=1", width=200>
</p>
"""


# ╔═╡ 58fdf4d3-7299-48e8-b27d-c6f9aa56aadb
md"""
## 1.3 地震灾害与预防: 场址效应
"""

# ╔═╡ 582d8581-01ab-4c60-bfef-0bda5abbb5b9
TwoColumn(
md"""
* 1985.9.19 $M_W 8.0$地震
* 距离墨西哥城320公里
![](https://box.nju.edu.cn/f/978bf5959894439c93d8/?dl=1)
""",
md"""
![](https://box.nju.edu.cn/f/885c6c6c94fd414ea663/?dl=1)
"""
	
)

# ╔═╡ aa0e9b44-ebfe-47b2-8baf-ddfb91ea6f7c
md"""
## 1.3 地震灾害与预防: 场址效应
"""

# ╔═╡ 20e9f8fd-8448-4b59-90c7-c3e967bfce73
html"""
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/15a0e09360414c7597b3/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ 27af8f37-8398-4d53-b5d6-0d702da70a74
html"""
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/5ef0633857a54d998487/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ b75729dd-fd51-40a6-aa0f-f36de4f39752
md"""
## 1.3 地震灾害与预防: 避险
!!! note "远离地震灾害"
	* 中国的地震灾害尤其严重
![](https://box.nju.edu.cn/f/3a86095841e842ada7ee/?dl=1)
"""

# ╔═╡ 00f24c4b-f056-41bd-948a-58a6ed533e34
md"""
## 1.3 地震灾害与预防: 预险
!!! note "地震预报"
	* 地震五要素: 时间, 地点, 震级
	* 中长期预报: 构造分析, 活断层研究, 地震周期研究
	* 短临预报: 地震活动性监测
"""

# ╔═╡ e3280e1b-208f-493d-ac70-ce497368d16d
html"""
<p style="display: flex; flex-direction: column; align-items:center; transform: translateY(0%)">
<img src="https://box.nju.edu.cn/f/6122e976a82a48d481b6/?dl=1" width="500" style="margin:auto">
<strong>海城地震预报</strong> 

</p>

"""

# ╔═╡ d2ecdf05-7ff1-4a62-b42a-f0327a7ebaaf
md"""
## 1.3 地震灾害与预防: 预险
!!! tip "地震预警"
	* 密集的地震观测台网
	* 实时地震监测与定位
	* P波最早到达,但破坏较小
![](https://box.nju.edu.cn/f/abea858857b3415798f2/?dl=1)
"""

# ╔═╡ c93f75d0-4183-4aaf-83db-cc8146503c09
md"""
## 1.3 地震灾害与预防: 预估
!!! note "地震灾害预评估"
	* 精细的断层结构与破裂过程
	* 精细的三维速度结构
	* 高效准确的模拟算法
	* 建筑参数与响应数据
"""

# ╔═╡ c1129724-2104-4b48-ad24-de7da072e720
html"""
<video width="700" height="400" controls style="border: 3px solid blue; background:lightblue;">
    <source src="https://box.nju.edu.cn/f/2164afdea48542cd8c29/?dl=1" type="video/mp4">
</video>
"""

# ╔═╡ fab615d9-c7a8-4832-99c2-60b47b67e98f
md"""
## 1.x 思考题
* 主要的全球地震带有哪些?它们各有什么特点?
* 中国的地震灾害为什么非常严重? 如何提高我国防震减灾的能力?
* 你家的房子安全吗? 从防震减灾的角度考虑, 你家房子需要做哪些改造?
* 1556年华县地震为什么会造成特别严重的人员伤亡?
"""

# ╔═╡ 0c281341-61f9-479b-9a16-c696d250e972


# ╔═╡ Cell order:
# ╠═7a7a1c1d-179c-4cf9-b32c-0be9c476fdbc
# ╠═5a2bc6db-cdb8-4b9f-833e-0828044d5ee0
# ╠═232c59fa-77b2-470c-ae85-fa8e8b14c301
# ╟─aaa0f3cc-f507-4f12-a611-0560fe8ecb24
# ╟─818bbfd3-181a-49fa-8e11-e61fc921cee8
# ╟─400ae1f1-4ee9-4f48-9fda-1f46918c452c
# ╟─c663c599-239d-4e5a-9d4b-2337eda0d6ba
# ╠═6e93b5df-0b60-4c38-8ed1-bf8d2f312eb7
# ╟─69d6d08f-b03f-4975-9974-6daacbf2576f
# ╟─08282040-eefc-4d50-b842-f2117e071f49
# ╟─a94a1f96-59ea-4447-a9e6-d3012549259c
# ╟─205a4f51-11c1-4b5e-8cf2-049cefe8c702
# ╟─8b453253-b6ce-4cd1-a8b4-f0ddb9fb1656
# ╟─9aae3fdf-1099-4c95-9fc0-7c3ce5fe7960
# ╟─78e2e603-77f0-4c30-ba9b-30f62e023b53
# ╟─38f7fc71-02c3-466e-9aee-706acca57daf
# ╟─215ed80f-00c9-4f1e-bba8-5bf2a20a063e
# ╟─a7c61f18-1a16-40dc-8c8a-e828e36d7404
# ╟─3f97fee8-1c72-4339-983f-cb4d5acecf84
# ╠═f0a13b7c-f714-47eb-9d19-0989aace349a
# ╠═8e1111d8-3324-4f32-ad7a-35d4e02e2fc1
# ╟─3081669b-f7e5-449e-a9c3-829372ddcb9d
# ╟─8063ff42-f205-47ac-b4ce-7e524a206fe3
# ╟─96f2c4be-a69a-4ed4-b3ab-2f375b14b233
# ╠═647c2323-6548-40b5-8fe5-a0d7019bbfd4
# ╟─6167a1ad-59ff-47d8-a2f9-c86c0439bb19
# ╟─1886f233-56d0-4984-a146-bfcad55a79da
# ╟─8f35f70c-5638-4fa7-8051-a9be0b7c971e
# ╟─26ed490b-8aba-41e6-a23e-f731ec0af022
# ╟─5bfa31eb-17d4-4458-b36c-b183669eb0fe
# ╟─9c7b180a-b295-46f6-8e18-cf244441cfb6
# ╟─8d902032-e100-4241-8bc0-ee97ffadd8ea
# ╟─b9dd8fcf-b74e-46bf-b0ba-00340dcaf3c2
# ╟─7dffd754-d5b4-4a28-93bd-f3fdda033b0d
# ╟─735758f6-0307-4528-95d8-968e1d040b31
# ╟─e72fd12b-9cef-43a5-85fc-2f7d72a850a1
# ╟─eecfe714-afa1-4336-88c2-00685388093e
# ╟─58fdf4d3-7299-48e8-b27d-c6f9aa56aadb
# ╟─582d8581-01ab-4c60-bfef-0bda5abbb5b9
# ╟─aa0e9b44-ebfe-47b2-8baf-ddfb91ea6f7c
# ╟─20e9f8fd-8448-4b59-90c7-c3e967bfce73
# ╟─27af8f37-8398-4d53-b5d6-0d702da70a74
# ╟─b75729dd-fd51-40a6-aa0f-f36de4f39752
# ╟─00f24c4b-f056-41bd-948a-58a6ed533e34
# ╟─e3280e1b-208f-493d-ac70-ce497368d16d
# ╟─d2ecdf05-7ff1-4a62-b42a-f0327a7ebaaf
# ╟─c93f75d0-4183-4aaf-83db-cc8146503c09
# ╟─c1129724-2104-4b48-ad24-de7da072e720
# ╟─fab615d9-c7a8-4832-99c2-60b47b67e98f
# ╠═0c281341-61f9-479b-9a16-c696d250e972
