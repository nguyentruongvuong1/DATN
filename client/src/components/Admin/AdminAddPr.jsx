import React, { useEffect, useState } from 'react';
import axios from 'axios';
import '../../styles/Admin/formaddsp.css'; // Import CSS file for styling
const FormThemSanPham = () => {
  const [cates, setCates] = useState([]);
  const [characteristic, setCharacteristic] = useState([]);
  const [typeCates, setTypeCates] = useState([]);
  const [selectedTypeCates, setSelectedTypeCates] = useState([]);
  const [imageFiles, setImageFiles] = useState([]);
   
//   Upload ảnh
  const handleFileUpload = async (e) => {
    const files = Array.from(e.target.files);
  
    const formDataUpload = new FormData();
    files.forEach(file => formDataUpload.append('images', file));
  
    try {
      const res = await axios.post(`${import.meta.env.VITE_API_URL}/adminpr/upload`, formDataUpload, {
        headers: { 'Content-Type': 'multipart/form-data' }
      });
  
      const newUrls = res.data.urls; // danh sách ảnh mới
      const currentImages = formData.images ? formData.images.split(',') : [];
  
      // Gộp ảnh cũ với ảnh mới
      const allImages = [...currentImages, ...newUrls];
      const allImagesStr = allImages.join(',');
  
      setFormData(prev => ({
        ...prev,
        images: allImagesStr
      }));
  
      // Cập nhật ảnh để preview
      setImageFiles(allImages);
    } catch (err) {
      console.error('Lỗi upload ảnh:', err);
      alert('Lỗi upload ảnh');
    }
  };
//  Xóa ảnh đã chọn
  const removeImage = (index) => {
    const newImageFiles = [...imageFiles];
    newImageFiles.splice(index, 1);
  
    setImageFiles(newImageFiles);
    setFormData(prev => ({
      ...prev,
      images: newImageFiles.join(',')
    }));
  };

  const [formData, setFormData] = useState({
    name: '',
    price: '',
    cate_id: '',
    characteristic_id: '',
    images: '',
    inventory_quantity: '',
    description: ''
  });

  // Lấy danh sách cate
  useEffect(() => {
    axios.get(`${import.meta.env.VITE_API_URL}/adminc/cate`).then((res) => {
      setCates(res.data);
      console.log(res.data);
    });
  }, []);

  // Khi chọn cate, lấy characteristic 
  useEffect(() => {
    if (formData.cate_id) {
      axios.get(`${import.meta.env.VITE_API_URL}/adminc/characteristic/${formData.cate_id}`)
        .then(res => setCharacteristic(res.data))
        .catch(err => console.error(err));
    }
  }, [formData.cate_id]);

  // Lấy type_cate theo characteristic được chọn
useEffect(() => {
    if (formData.characteristic_id) {
      axios.get(`${import.meta.env.VITE_API_URL}/adminc/type_cates/${formData.characteristic_id}`)
        .then(res => setTypeCates(res.data))
        .catch(err => console.error(err));
    } else {
      setTypeCates([]); // nếu chưa chọn đặc điểm, xóa hết type_cates
    }
  }, [formData.characteristic_id]);

  const handleTypeCateChange = (id) => {
    setSelectedTypeCates(prev =>
      prev.includes(id)
        ? prev.filter(item => item !== id)
        : [...prev, id]
    );
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const payload = {
      ...formData,
      type_cate_ids: selectedTypeCates
    };

    axios.post(`${import.meta.env.VITE_API_URL}/adminpr/products`, payload)
      .then(() => {
        alert('Tạo sản phẩm thành công!');
        // Reset form
        setFormData({
          name: '',
          price: '',
          cate_id: '',
          images: '',
          inventory_quantity: '',
          description: ''
        });
        setSelectedTypeCates([]);
        setTypeCates([]);
        setCharacteristic(null);
      })
      .catch(err => {
        console.error(err);
        alert('Lỗi khi tạo sản phẩm');
      });
  };

  return (
    <div className="form-wrapper">
    <h2>Thêm sản phẩm</h2>
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <label>Tên sản phẩm:</label>
        <input className="form-control" type="text" name="name" value={formData.name} onChange={handleInputChange} required />
      </div>
  
      <div className="form-group">
        <label>Giá:</label>
        <input className="form-control" type="number" name="price" value={formData.price} onChange={handleInputChange} required />
      </div>
  
      <div className="form-group">
        <label>Danh mục:</label>
        <select className="form-control" name="cate_id" value={formData.cate_id} onChange={handleInputChange} required>
          <option value="">-- Chọn danh mục --</option>
          {cates.map(cate => (
            <option key={cate.id} value={cate.id}>{cate.name}</option>
          ))}
        </select>
      </div>

    
      {characteristic.length > 0 && (
  <div className="form-group">
    <label>Đặc điểm:</label>
    <select
  className="form-control"
  name="characteristic_id"
  value={formData.characteristic_id}
  onChange={handleInputChange}
  disabled={!formData.cate_id}
  required
>
  <option value="">-- Chọn đặc điểm --</option>
  {characteristic.map((item) => (
    <option key={item.id} value={item.id}>{item.name}</option>
  ))}
</select>
  </div>
)}
  
  {typeCates.length > 0 && (
  <div className="form-group checkbox-group">
    <label>Loại:</label><br />
    {typeCates.map(type => (
      <label key={type.id}>
        <input
          type="checkbox"
          checked={selectedTypeCates.includes(type.id)}
          onChange={() => handleTypeCateChange(type.id)}
        /> {type.name}
      </label>
    ))}
  </div>
)}
  
  <div className="form-group">
  <label>Ảnh sản phẩm:</label>
  <input
    className="form-control"
    type="file"
    multiple
    accept="image/*"
    onChange={(e) => handleFileUpload(e)}
  />
</div>

{imageFiles.map((url, index) => (
  <div key={index} style={{ position: 'relative', display: 'inline-block', margin: '5px' }}>
    <img src={url} alt={`ảnh-${index}`} style={{ width: '100px' }} />
    <button
      type="button"
      onClick={() => removeImage(index)}
      style={{
        position: 'absolute', top: 0, right: 0,
        background: 'red', color: 'white', border: 'none', borderRadius: '50%'
      }}
    >
      ×
    </button>
  </div>
))}
  
      <div className="form-group">
        <label>Số lượng tồn kho:</label>
        <input className="form-control" type="number" name="inventory_quantity" value={formData.inventory_quantity} onChange={handleInputChange} />
      </div>
  
      <div className="form-group">
        <label>Mô tả:</label>
        <textarea className="form-control form-textarea" name="description" value={formData.description} onChange={handleInputChange} />
      </div>
  
      <button className="submit-btn" type="submit">Thêm sản phẩm</button>
    </form>
  </div>
  );
};

export default FormThemSanPham;
