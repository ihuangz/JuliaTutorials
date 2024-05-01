### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ bf99c3a3-6f71-45f4-bef6-e4edfb34e291
begin
	using Pkg
	Pkg.activate()
	using PlutoUI,GMT
end

# ╔═╡ 0422891e-0f96-46c9-b571-7eb321380469
html"""
<img src="https://box.nju.edu.cn/f/6b803929ecff44888fff/?dl=1" alt="image" width="200" height="auto">
"""

# ╔═╡ 43006b38-8860-4139-9263-4ee12a216326
begin
	x = 0:0.01:2pi
	y = sin.(x)
	z = cos.(x) 
	plot(x,y,lw=2,lc=:red,ls=:dash,label="sin(x)") 
	plot!(x,z,lw=1,lc=:blue,ls=:dot,label="cos(x)") 
	basemap!(title="Test",xlabel="x",ylabel="y") 
	basemap!(frame=0,show=true)
end

# ╔═╡ 2027c185-48c4-4eb5-9c26-fa5e03ec09c2
coast(region=(-180, 180, -90, 90), 
    proj=(name=:Robinson, center=0),
    resolution=:crude,
    land=:white, water=:white, area=7000,figsize=15,
    shore=:thinnest,
    frame=(annot=45, grid=45,ticks=45),
    fmt = :jpg,show=true)

# ╔═╡ 83357d7c-de2a-46bb-8b2b-8651e83b83b2
begin
	x2 = range(0, stop=2pi, length=180);       
	seno = sin.(x2/0.2)*45;
	coast(region=[0 360 -90 90], proj=(name=:laea, center=(300,30)), frame=:g, res=:crude, land=:navy, figsize=3)
	plot!(collect(x2)*60, seno, lw=0.5, lc=:red, marker=:circle, markeredgecolor=0, size=0.05, markerfacecolor=:cyan, show=true)
end

# ╔═╡ Cell order:
# ╠═bf99c3a3-6f71-45f4-bef6-e4edfb34e291
# ╠═0422891e-0f96-46c9-b571-7eb321380469
# ╠═43006b38-8860-4139-9263-4ee12a216326
# ╠═2027c185-48c4-4eb5-9c26-fa5e03ec09c2
# ╠═83357d7c-de2a-46bb-8b2b-8651e83b83b2
