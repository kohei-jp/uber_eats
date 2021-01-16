import axios from 'axios';
import { orders } from '../urls/index'

export const postOrder = async(params) => {
  console.log(params.line_food_ids)
  return await axios.post(orders,
    { line_food_ids: params.line_food_ids }
  )
  .then(res => {
    console.log("送信完了")
    return res.data
  })
  .catch((e) => 
    console.log("送信失敗")
    // console.error(e)
    )
};