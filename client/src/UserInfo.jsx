import { useEffect } from "react";
import { useDispatch } from "react-redux";
import { checkLogin } from "./AuthSlice";

export default function UserInfo() {
  const dispatch = useDispatch();

  useEffect(() => {
    dispatch(checkLogin());
  }, [dispatch]);

  return null; // Không render gì cả
}