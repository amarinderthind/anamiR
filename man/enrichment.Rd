% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/enrichment.R
\name{enrichment}
\alias{enrichment}
\title{Enrich pathways with genes from putative miRNA-target gene interactions.}
\usage{
enrichment(data_support, org = c("hsa", "mmu"), per_time = 5000)
}
\arguments{
\item{data_support}{matrix format generated from
\link{database_support}.}

\item{org}{species of genes and miRNAs, only support "hsa", "mmu"}

\item{per_time}{Times of permutation about each enriched pathways,
higher times, more precise empirical p-value user can obtain,
meanwhile, this function would cost more time. Default is 5000.}
}
\value{
matrix format. There are 7 columns in it, including
   database, term, total genes of the term,  targets in the term,
   targets in total genes of the term (%), raw p-value, empirical
   p-value.
}
\description{
This function will do function analysis with genes from potential
miRNA-target gene interactions in the input data.frame, which is
generated by \link{database_support}, with total 4 kinds of pathway
databases, including mouse and human two species, beseides, this
function will permute 5000 times (Default) for each pathway to show
an empirical p_value to avoid the bias from hypergeometric p-value,
this indicating that it would take a few minutes to do functional
analysis.
}
\examples{
## Use the internal dataset
data("mirna", package = "anamiR", envir = environment())
data("pheno.mirna", package = "anamiR", envir = environment())
data("mrna", package = "anamiR", envir = environment())
data("pheno.mrna", package = "anamiR", envir = environment())

## SummarizedExperiment class
require(SummarizedExperiment)
mirna_se <- SummarizedExperiment(
 assays = SimpleList(counts=mirna),
 colData = pheno.mirna)

## SummarizedExperiment class
require(SummarizedExperiment)
mrna_se <- SummarizedExperiment(
 assays = SimpleList(counts=mrna),
 colData = pheno.mrna)

## Finding differential miRNA from miRNA expression data with t.test
mirna_d <- differExp_discrete(
   se = mirna_se,
   class = "ER",
   method = "t.test"
)

## Finding differential mRNA from mRNA expression data with t.test
mrna_d <- differExp_discrete(
   se = mrna_se,
   class = "ER",
   method = "t.test"
)

## Convert annotation to miRBse 21
mirna_21 <- miR_converter(data = mirna_d, original_version = 17)

## Correlation
cor <- negative_cor(mrna_data = mrna_d, mirna_data = mirna_21)

## Intersect with known databases
sup <- database_support(cor_data = cor)

## Functional analysis
pat <- enrichment(data_support = sup, org = "hsa", per_time = 100)

}
\seealso{
\code{\link[stats]{Hypergeometric}} for details.
}
