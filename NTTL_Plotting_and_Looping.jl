### Winsorization: Removes low or high extremes from dataset
using Statistics

function winsorize_image(image, low_percentile::Float64, high_percentile::Float64)

    flat = vec(image)
    flat_clean = filter(!isnan, collect(skipmissing(flat)))

    @assert 0.0 <= low_percentile < high_percentile <= 1.0

    low = quantile(flat_clean, low_percentile)
    high = quantile(flat_clean, high_percentile)

    return clamp.(image, low, high)
end

### Looping & Plotting: Set path, choose years, and set bounding box
#This example uses Geita Mines
using Rasters
using DimensionalData: Between
using Statistics
using Plots
using DataFrames

path = "Path/to/File"
years = 2014:2024

GM_bounds = (
    X(Between(31.93176, 32.6788))
    Y(Between(-3.09115, -2.68243))
)

#Loop each year, find the mean light values from each year, and save to DataFrame
mean_light = Float64[]

for year in years
    file = jionpath(path, string(year) * ".tif")
    img = Raster(file, lazy=true)
    GM_nl = img[GM_bounds...]
    winimg = winsorize_image(GM_nl, 0.01, 0.99)
    push!(mean_light, mean(skipmissing(vec(Array(winimg)))))
end

data_f = DataFrame(year=years, mean_light=mean_light)
println(data_f)

#Plot line graph with title and axis' labeled
plot(data_f.year, data_f.mean_light, xlabel="Year", ylabel="Mean Light Intensity", title="Geita Mine and Town, Tanzania, NTTL 2014-2024", marker=:circle, xticks=(data_f.year, string.(data_f.year)), legend=false)

#Save graph as a png image (uncomment the lines below if you want to save the image)
    # GM_nl_graph = plot(data_f.year, data_f.mean_light, xlabel="Year", ylabel="Mean Light Intensity", title="Geita Mine and Town, Tanzania, NTTL 2014-2024", marker=:circle, xticks=(data_f.year, string.(data_f.year)), legend=false)
    # savefig(GM_nl_graph,"desired/path/to/save/GM_nl_graph.png")
