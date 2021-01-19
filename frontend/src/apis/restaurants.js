// フロントエンドからAPIを叩くための関数
import axios from 'axios';
import { restaurantsIndex } from '../urls/index'

// railsのAPIを叩いて、JSON形式でデータが帰ってくる
export const fetchRestaurants = async() => {
  // get(uri)メソッドの基本形. POSTならaxios.post(...)
  return await axios.get(restaurantsIndex)
  .then(res => {
    console.log(res.data);
    return res.data
  })
  // 本来は、varidationエラーを返す
  .catch((e) => console.error(e))
}

// axiosはPromiseベース(Promiseを返す). newPromiseをしなくて良い