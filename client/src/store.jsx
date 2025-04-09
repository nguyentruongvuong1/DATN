import { configureStore } from "@reduxjs/toolkit";
import AuthSlice from "./AuthSlice";
import cartReducer from "./CartSlice"; 
export const store = configureStore({
    reducer: { 
        auth: AuthSlice, cart: cartReducer
    }
}) 