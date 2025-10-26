# Mineral-Deposits-and-Economic-Prosperity
Code and coordinates used for the Mineral Deposits and Economic Prosperity paper. 

We used three main functions in our program to analyze NTTL development - winsorization, loops, and plotting. Winsorization was important in removing extreme highs and lows, negating the likelihood that outliers skewed our results. We then looped the code to run over each year, and plotted to visualize the NTTL, both as line-charts and image representations. 

The code for the winsorization, loops, and plotting, is in the "NTTL_Plotting_and_Looping.jl" file. 
To see the coordinates used for each mine, look in the "Coordinates_used.txt" file. 

To download the files used:
  1. Go to https://eogdata.mines.edu/nighttime_light
  2. Follow the path annual > v21
  3. From there, download the average masked zip files for 2014-2024 into one folder
  4. Rename the files as their respective years

After you have the files, rename the path in the Julia file to the folder path.

Using the code:
  - Make sure paths are renamed properly
  - If you'd like to save the graph as a .png, uncomment the bottom two lines and fill in your desired path
