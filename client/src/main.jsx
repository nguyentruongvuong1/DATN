import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { store } from './store.jsx';
import { Provider } from 'react-redux';
import './index.css'
import App from './App.jsx'
import 'bootstrap/dist/css/bootstrap.min.css';

createRoot(document.getElementById('root')).render(
  <Provider store={store}>
    <App />
  </Provider>,
)
