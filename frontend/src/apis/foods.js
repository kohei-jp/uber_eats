import axios from "axios"
import {foodsIndex} from "../urls/index"

export const fetchFoods = async(resutaurantId) => {
  return await axios.get(foodsIndex(resutaurantId))
  .then(res => {
    return res.data
  })
  .catch((e)=> console.log.error(e))
}