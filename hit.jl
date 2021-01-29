### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 056d199c-6256-11eb-292f-4dea6b16a1a8
using Plots, HDF5, DelimitedFiles, PlutoUI

# ╔═╡ 6d2ee686-6257-11eb-106b-25162d4a6090
begin
	folder = pwd()*"/no-ppart/Re065-128/outputdir";
	fname = folder*"/stafield_master.h5";
	fid = h5open(fname,"r");
	X, Y = read(fid["X_Cordin"]), read(fid["Y_Cordin"]);
	close(fid);
	xmax, ymax = round(X[end],digits=2), round(Y[end],digits=2);
end

# ╔═╡ 8bb03044-625c-11eb-0bd1-91768f94d0bc
md"Size of the domain is $(xmax) $$\times$$ $(ymax)"

# ╔═╡ f0f46170-6258-11eb-2d9a-8dae6137026d
nxm, nym = Int(size(X)[1]), Int(size(Y)[1]);

# ╔═╡ 796685b2-625c-11eb-2059-25e6179bfc9a
md"Now load the 3D file"

# ╔═╡ 67c0c6fa-6258-11eb-1975-7319bcd7730f
begin
	md"Now load the 3D file"
	fname_cont = folder*"/continua_vx.h5"
	fid_cont = h5open(fname_cont,"r")
	Vx = read(fid_cont["Vx"])
	close(fid_cont)
end

# ╔═╡ af3ed80a-625d-11eb-1bfb-6d6d9845fe40
md"Here, you can choose the index location `num` that you want to plot"

# ╔═╡ f0bf715c-625a-11eb-303f-0d95dcd4af4d
@bind num Slider(1:nxm; default=nxm/2, show_value=true)

# ╔═╡ 9765566e-6258-11eb-03e3-5313cb4c4e89
begin
	Vx_slice = Vx[num,1:end-1,:]
	md"Size of slice is $(size(Vx_slice))"
	md"Plotting at the $(num)'th index location, which is z = $(round(X[num],digits=2)) L."
end

# ╔═╡ 72c6e518-625b-11eb-1c2e-d7bd3934a152
begin
	p = heatmap(X, Y, Vx_slice,
    	 		ratio=:equal, c=:thermal, 
    	 		xlims=(0,xmax), ylims=(0,ymax), clims=(-8,8),
    	 		title="Velocity", size=(1024,1024),
				xtickfont = font(40),
				ytickfont = font(40),
				titlefont = font(40),
				legend = :none)
end

# ╔═╡ Cell order:
# ╠═056d199c-6256-11eb-292f-4dea6b16a1a8
# ╠═6d2ee686-6257-11eb-106b-25162d4a6090
# ╠═8bb03044-625c-11eb-0bd1-91768f94d0bc
# ╠═f0f46170-6258-11eb-2d9a-8dae6137026d
# ╟─796685b2-625c-11eb-2059-25e6179bfc9a
# ╠═67c0c6fa-6258-11eb-1975-7319bcd7730f
# ╠═af3ed80a-625d-11eb-1bfb-6d6d9845fe40
# ╠═f0bf715c-625a-11eb-303f-0d95dcd4af4d
# ╠═9765566e-6258-11eb-03e3-5313cb4c4e89
# ╠═72c6e518-625b-11eb-1c2e-d7bd3934a152
