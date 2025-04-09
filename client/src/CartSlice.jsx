import {createSlice} from '@reduxjs/toolkit';

const saveCart = (cartState) =>{
    localStorage.setItem('cart', JSON.stringify(cartState));
};

const loadCartFromLocalStorage = () =>{
    try {
        const Cart = localStorage.getItem('cart');
        if(Cart === null) return [];
        return JSON.parse(Cart)
    }catch(err){
        console.error("Failed to load cart from localStorage:", err);
        return [];
    }
};

const initialState = {listPr: loadCartFromLocalStorage() };

export const cartSlice = createSlice({
    name: 'cart',
    initialState,
    reducers: {
        themPr: (state, action) => {
            const pr = action.payload;
            const index = state.listPr.findIndex(p => p.id === pr.id);
            if (index === -1) {
                state.listPr.push({ ...pr, so_luong: pr.so_luong || 1 });
            } else {
                state.listPr[index].so_luong += pr.so_luong || 1;
            }
            saveCart(state.listPr);
        },

        SuaSL: (state, action) =>{
            const [id, so_luong] = action.payload;
            const index = state.listPr.findIndex(p => p.id === id);
            if(index !== -1){
                state.listPr[index].so_luong = Number(so_luong);
                saveCart(state.listPr);
            }
        },

        XoaPr: (state, action) =>{
            const id = action.payload;
            const index = state.listPr.findIndex(p => p.id === id);
            if(index !== -1){
                state.listPr.splice(index, 1);
                saveCart(state.listPr);
            }
        },

        XoaGH: (state) =>{
            state.listPr = [];
            saveCart(state.listPr)
        }
    }
})


export const {themPr, SuaSL, XoaGH, XoaPr} = cartSlice.actions
export default cartSlice.reducer;