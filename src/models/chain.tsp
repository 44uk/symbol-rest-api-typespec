import "../types";
import "./common.tsp";

model ChainInfoDTO {
  height: Height;
  scoreHigh: Score;
  scoreLow: Score;
  latestFinalizedBlock: FinalizedBlockDTO;
}
