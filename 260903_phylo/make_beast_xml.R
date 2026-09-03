library(beautier)

args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]

make_xml <- function(tag, sample_from_prior = FALSE) {

  mcmc <- create_mcmc(
    chain_length = 500000,       # suficiente para práctica; usar más para análisis real
    store_every = 1000,
    sample_from_prior = sample_from_prior,
    tracelog = create_tracelog(
      filename = file.path("beast_run", paste0(tag, ".log")),
      log_every = 1000
    ),
    treelog = create_treelog(
      filename = file.path("beast_run", paste0(tag, ".trees")),
      log_every = 1000
    )
  )

  create_beast2_input_file(
    input_filename = input_file,
    output_filename = file.path("beast_run", paste0(tag, ".xml")),
    site_model = create_hky_site_model(),
    clock_model = create_strict_clock_model(),
    tree_prior = create_yule_tree_prior(),
    mcmc = mcmc
  )
}

make_xml(paste0(input_file,"_run1"), sample_from_prior = FALSE)
make_xml(paste0(input_file,"_run2"), sample_from_prior = FALSE)
make_xml(paste0(input_file,"_prior"), sample_from_prior = TRUE)