//定数の読み込み
import {REQUEST_STATE} from "../../constants";

//initialState
export const initialState = {
  fetchState: REQUEST_STATE.INITIAL, // GET_APIの状態
  restaurantsList: [], // 取得したレストランの情報
};

//actionType(定数に文字列を入れる)
export const restaurantsActionTypes = {
  FETCHING: "FETCHING",
  FETCH_SUCCESS: "FETCH_SUCCESS",
}

//reducer
export const restaurantsReducer = (state=initialState, action) => {
  switch (action.type) {
    case restaurantsActionTypes.FETCHING:
      return {
        ...state,
        fetchState: REQUEST_STATE.LOADING,
      };
    case restaurantsActionTypes.FETCH_SUCCESS:
      return {
        fetchState: REQUEST_STATE.OK,
        restaurantsList: action.payload.restaurants,
      };
    default:
      throw new Error();
  }
}