import { BlockMap } from "builder-util-runtime/out/blockMapApi"
import { DifferentialDownloader } from "./DifferentialDownloader"

export class GenericDifferentialDownloader extends DifferentialDownloader {
  download(oldBlockMap: BlockMap, newBlockMap: BlockMap) {
    return this.doDownload(oldBlockMap, newBlockMap)
  }
}