import {createSlice, createAsyncThunk} from "@reduxjs/toolkit";
import moment from 'moment';
const initialState = {DaDangNhap: false, user: null,  token: null, expiresIn: 0, countPrlike: 0, isChecked: false,}

export const fetchCountPrLike = createAsyncThunk(
    'auth/fetchCountPrLike',
    async (userId) => {
      const response = await fetch(`${import.meta.env.VITE_API_URL}/pr/count-pr-like/${userId}`);
      const data = await response.json();
      return data.count; // API trả về số lượng sản phẩm yêu thích
    }
  );

export const AuthSlice = createSlice({
    name: 'Auth',
    initialState,
    reducers:{
      

        checkLogin: (state) => {
            let token = localStorage.getItem('token');
            let user = localStorage.getItem('user');
            // let expiresIn = localStorage.getItem('expiresIn');
            const expiresAt = localStorage.getItem('expiresAt');

            if (!token || !user || !expiresAt) {
                
                state.DaDangNhap = false;
                state.isChecked = true
                return;
            }
        
            // let expiresAt = moment().add(Number(expiresIn), 'second');
            let chua_het_han = moment().isBefore(expiresAt);
        
            if (chua_het_han) {
                state.user = JSON.parse(user);
                state.token = token;
                // state.expiresIn = Number(expiresIn);
                state.isChecked = true;
                state.DaDangNhap = true;
            } else {
                // Nếu token hết hạn, tự động đăng xuất
                state.token = null;
                state.user = null;
                state.expiresIn = 0;
                state.DaDangNhap = false;
                state.isChecked = true;

                localStorage.removeItem('token');
                localStorage.removeItem('user');
                localStorage.removeItem('expiresIn');
                localStorage.removeItem('expiresAt');
            }
        },

        DaLogin: (state, params) =>{
            state.token = params.payload.token;
            state.expiresIn = params.payload.expiresIn
            state.user = params.payload.userInfo;
            state.DaDangNhap = true;
            state.isChecked = true;
            localStorage.setItem('token', state.token);
            localStorage.setItem('user', JSON.stringify(state.user));
            localStorage.setItem('expiresIn', state.expiresIn)
            const expiresAt = moment().add(state.expiresIn, 'seconds').toISOString();
            localStorage.setItem('expiresAt', expiresAt);
        },

        thoat: (state) =>{
            localStorage.removeItem('token');
            localStorage.removeItem('user');
            localStorage.removeItem('expiresIn');
            state.token = null;
            state.user = null;
            state.expiresIn = null;
        },

        setFavoriteCount: (state, action) =>{
            state.countPrlike = action.payload;
        },
        updateCountPrlike : (state, action) =>{
            state.countPrlike += action.payload;
        },
       
    },
    extraReducers: (builder) => {
        builder.addCase(fetchCountPrLike.fulfilled, (state, action) => {
          state.countPrlike = action.payload; // Lấy số lượng yêu thích từ API
        });
      }
});

export const {DaLogin, checkLogin, thoat, setFavoriteCount, updateCountPrlike} = AuthSlice.actions;
export default AuthSlice.reducer