# Check and install packages if needed
if (!require("ggplot2")) install.packages("ggplot2")

library(ggplot2)

# 1. Read the Matrix File
cat("Reading matrix_long_form.tsv...\n")
# 'fread' from data.table is faster/lighter, but we stick to standard read.table for simplicity
data <- read.table("matrix_long_form.tsv", header=TRUE)

# 2. Check size and Downsample if necessary
#    If we have more than 500,000 points, we randomly keep 500,000.
#    This prevents the "Killed" (Out of Memory) error.
MAX_POINTS <- 500000

if (nrow(data) > MAX_POINTS) {
  cat("Dataset is huge (", nrow(data), " rows). Sampling 500,000 points to save RAM...\n")
  set.seed(42) # Ensures the random sample is the same every time
  data <- data[sample(nrow(data), MAX_POINTS), ]
}

cat("Generating Plot with ", nrow(data), " points...\n")

# 3. Create the Heatmap (Using geom_bin2d for efficiency)
#    geom_bin2d groups points into little boxes, which is MUCH faster/lighter than geom_raster
p <- ggplot(data, aes(x=offset, y=fragment_length)) +
  
  # bin2d automatically counts how many points fall in a square
  geom_bin2d(bins = 100) + 
  
  # Colors: White (Low) -> Blue -> Red (High)
  scale_fill_gradientn(colours = c("white", "skyblue", "dodgerblue", "firebrick")) +
  
  # Labels
  labs(title="V-Plot Matrix (Sampled)",
       x="Genomic Position (bp)",
       y="Fragment Length (bp)",
       fill="Count") +
  
  # Theme settings
  theme_minimal() +
  theme(panel.grid = element_blank()) +
  
  # LIMITS:
  # Restrict Y (Length) to 0-500
  coord_cartesian(ylim=c(0, 500))

# 4. Save the Output
ggsave("vplot_result.png", plot=p, width=10, height=6, dpi=300)
cat("Done! Plot saved as 'vplot_result.png'.\n")