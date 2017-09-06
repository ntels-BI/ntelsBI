#' Write rda about imported tables
#' @description 워킹디렉토리에 존재하는 테이블 파일들을 import 한 후 rda 형태로 모두 변환합니다. 기호에 따라 변환되고 난 후 csv 파일을 지울 수 있습니다. 본 함수는 \code{readr::read_csv()} 함수에 의존성을 가지고 있습니다.
#' @param path a character
#' @param delete
#' @param method choice machine learning algorithm method
#' @param fitImage a character. Input filename for chaching fit Object
#' @return \code{rda} 포맷에서 객체의 이름은 \code{rawdata} 로 지정되어 저장됩니다.
#' @export

csv2rda <- function(pattern = NULL, delete = F, format = c("csv", "txt"), ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  if(is.null(pattern)){
    impFormat <- paste0(format, collapse = "|") %>% paste0("\\.(", ., ")$")
    impPat <- grep(impFormat, list.files(), perl = T, value = T)
  } else impPat <- grep(pattern, list.files(), perl = T, value = T)

  ## Output (saving .rda format)
  for(i in impPat){
    rawdata <- read_csv(i)
    save(rawdata, file = gsub("\\.(txt|csv)$", ".rda", i))
  }

  if(delete) file.remove(impPat)

}
