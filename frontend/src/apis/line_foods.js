import axios from 'axios';
import { lineFoods, lineFoodsReplace } from '../urls/index'

// 購入予定の入力情報を送信する
export const postLineFoods = async(params) => {
  // リソース(仮注文)を新規で作成 => POST or PUT
  return await axios.post(lineFoods,
    {
      food_id: params.foodId,
      count: params.count,
    }
  )
  .then(res => {
    return res.data
  })
  .catch((e) => { throw e; })
};

// 新規注文を開始する場合
export const replaceLineFoods = async(params) => {
  // 既に存在するリソース(仮注文)を更新する => PUT or PATCH
  return await axios.put(lineFoodsReplace,
    {
      food_id: params.foodId,
      count: params.count,
    }
  )
  .then(res => {
    return res.data
  })
  .catch((e) => { throw e; })
};

export const fetchLineFoods = async() => {
  return await axios.get(lineFoods)
  .then(res => {
    return res.data
  })
  .catch((e) => { throw e; })
};
