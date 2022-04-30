Best Practices for Creating and Maintaining Lab Protocols in R Markdown
================
Isaac Petersen
April 30, 2022

-   <a href="#1-creating-a-lab-protocol"
    id="toc-1-creating-a-lab-protocol">1 Creating a Lab Protocol</a>
-   <a href="#2-best-practices" id="toc-2-best-practices">2 Best
    Practices</a>
-   <a href="#3-session-info" id="toc-3-session-info">3 Session Info</a>
    -   <a href="#31-rstudio-version" id="toc-31-rstudio-version">3.1 Rstudio
        Version</a>

The `.md` and `.html` files are generated from the `.Rmd` file. Make
sure to make any edits to the `.Rmd` file (not the `.md` and `.html`
files).

# 1 Creating a Lab Protocol

To create a lab protocol, create a `.Rmd` file with the following `YAML`
header at the top of the file:

``` yaml
---
title: "Best Practices for Creating and Maintaining Lab Protocols in R Markdown"
author: "INSERT AUTHOR NAME"
date: "`r format(Sys.time(), '%d %B, %Y')`"
output: 
  html_document:
    toc: true
    toc_float: true
    number_sections: true
    code_folding: hide
    df_print: paged
  github_document:
    html_preview: FALSE
    toc: true
    number_sections: true
  pdf_document:
    toc: yes
    number_sections: yes
---
```

Then, include the following as the first code chunk:

```` markdown
```{r setup, include = FALSE}
knitr::opts_chunk$set(echo = TRUE,
                      error = TRUE)
```
````

Then, include whatever text and/or code chunks.

The `.md` and `.html` files are generated from the `.Rmd` file. Make
sure to make any edits to the `.Rmd` file (not the `.md` and `.html`
files). Then, knit the `.Rmd` file to update the `.md` and `.html`
files. This is done automatically when committing a change to GitHub.
After the knitting is complete, you can fetch the created `.md` and
`.html` files by fetching the latest version of the repo in the GitHub
repo.

# 2 Best Practices

Adapted from
[here](https://github.com/lowepowerlab/protocols/blob/main/markdown_best_practices.md):

-   **Use a new line for every sentence.** This helps with version
    control—individually changed sentences will be highlighted upon
    commits (easy to parse) rather than whole paragraphs (nightmare to
    parse).

    -   This formatting is incompatible with a double space after
        period. Do a find and replace for `".  "` → `". "` Be careful
        not to blanket remove all double spaces because tabbed bullets
        have 3 spaces.

-   Add protocol entries as links to the `README.md`

-   Add linked content (e.g. images, excel workbooks, etc) to
    sub-directories

-   Use no spaces in file or folder names. Use a dash (-) instead of a
    space.

-   When making numbered lists, just use `1.` for all numbers. Markdown
    will make them sequential automatically. This is helpful if you go
    back & add additional entries later.

-   Use `"XXX"` to indicate an area that needs editing. This will allow
    the lab to `CTRL+F` for `"XXX"` and find areas that need editing.

-   To update the list of R packages that are installed for running the
    `.Rmd` files, update the `DESCRIPTION` file.

# 3 Session Info

``` r
sessionInfo()
```

    ## R version 4.2.0 (2022-04-22)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Ubuntu 20.04.4 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.9.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
    ##  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
    ##  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
    ## [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] compiler_4.2.0  magrittr_2.0.3  fastmap_1.1.0   cli_3.3.0      
    ##  [5] tools_4.2.0     htmltools_0.5.2 yaml_2.3.5      stringi_1.7.6  
    ##  [9] rmarkdown_2.14  knitr_1.39      stringr_1.4.0   xfun_0.30      
    ## [13] digest_0.6.29   rlang_1.0.2     evaluate_0.15

## 3.1 Rstudio Version

``` r
rstudioapi::versionInfo()
```

    ## Error: RStudio not running
