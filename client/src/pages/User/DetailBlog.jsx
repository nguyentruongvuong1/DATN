import React, { useEffect, useState } from "react";
import { Container, Row, Col } from "react-bootstrap";
import { useParams } from "react-router-dom";
import "../../styles/User/BlogDetail.css"
import { Link } from "react-router-dom";

const DetailBlog = () => {
    const { id } = useParams(); // Lấy ID từ URL
    const [blogs, setBlogs] = useState([]);
    const [newsList, setNewsList] = useState([]);
    useEffect(() => {
        fetch(`${import.meta.env.VITE_API_URL}/blog`)
            .then((res) => res.json())
            .then((data) => setBlogs(data.data));
    }, []);
    useEffect(() => {
        fetch(`${import.meta.env.VITE_API_URL}/blog/${id}`)
            .then((res) => res.json())
            .then((data) => setNewsList(data.data));
    }, [id]);

    return (
        <>
            <Container>
                <Row>
                    <Col md={8}>
                        <div className="content_project_detail">
                            <div className="content_header_detail">
                                <a href="">
                                    <img
                                        className="img_project_detail"
                                        src={newsList.logo}
                                        alt={newsList.logo}
                                    />
                                </a>
                            </div>
                            <div className="content_project_body_detail">
                                <h3 className="title_detail_blog">{newsList.title}</h3>
                                <p>{newsList.content}</p>
                                <p>{newsList.description}</p>

                            </div>
                        </div>
                    </Col>
                    <Col md={4} >
                        <div>
                            <h3>Tất cả bài viết</h3>
                            <div className="sidebar">
                                {blogs.map((blog) => (
                                    <div className="content-sidebar">
                                        <Link
                                            className="p_sidebar_content"
                                            to={`/blog/${blog.id}`}
                                        >
                                            {" "}
                                            <img className="sidebarImages" src={blog.logo} alt="" />
                                        </Link>
                                        <Link
                                            className="p_sidebar_content"
                                            to={`/blog/${blog.id}`}
                                        >
                                            {" "}
                                            <a href="" className="p_sidebar_content">
                                                {blog.title}
                                            </a>
                                        </Link>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </Col>
                </Row>
            </Container>
        </>
    );
};

export default DetailBlog;
