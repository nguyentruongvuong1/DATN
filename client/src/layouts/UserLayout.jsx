import { Outlet } from "react-router-dom"
import Header from "../components/User/Header"
import Footer from "../components/User/Footer"

export default function UserLayout() { 
    return (
        <div>
        <Header />
        <main>
            <Outlet />
        </main>
        <Footer />
        </div>
    )
}