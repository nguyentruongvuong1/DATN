import { useState, useEffect } from 'react';
import "../../styles/User/Blog.css"
import Row from "react-bootstrap/Row";
import Col from "react-bootstrap/Col";
import { Container } from "react-bootstrap";
import { Link } from "react-router-dom";

export default function Blog() {
    const [newsList, setNewsList] = useState([]);
    useEffect(() => {
        fetch(`${import.meta.env.VITE_API_URL}/blog`)
            .then((res) => res.json())
            .then((data) => setNewsList(data.data));
    }, []);
    return (

        <Container>
            <h2 className="text-center mb-4">Danh sách tin tức</h2>
            <Row className="justify-content-center">
                {newsList.map((item) => (
                    <Col key={item.id} md={4} className="mb-4 d-flex justify-content-center">
                        <div className="news-item text-center">
                            <img src={item.logo} alt={item.title} className="news-image img-fluid mb-2" />
                            <p className="news-title">{item.content}</p>
                            <Link to={`/blog/${item.id}`}> <button class="btn-detail">Xem chi tiết</button></Link>
                        </div>
                    </Col>
                ))}
            </Row>
        </Container>

    );
}