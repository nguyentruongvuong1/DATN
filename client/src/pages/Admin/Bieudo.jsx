import React, { useEffect, useRef } from "react";
import Chart from "chart.js/auto";

const Bieudo = () => {
  const chartRef1 = useRef(null);
  const chartRef2 = useRef(null);
  const chartInstance1 = useRef(null);
  const chartInstance2 = useRef(null);

  useEffect(() => {
    if (chartRef1.current && chartRef2.current) {
      const ctx1 = chartRef1.current.getContext("2d");
      const ctx2 = chartRef2.current.getContext("2d");

      // Hủy biểu đồ cũ nếu có
      if (chartInstance1.current) chartInstance1.current.destroy();
      if (chartInstance2.current) chartInstance2.current.destroy();

      // Tạo biểu đồ mới
      chartInstance1.current = new Chart(ctx1, {
        type: "polarArea",
        data: {
          labels: ["Facebook", "Youtube", "Shopee"],
          datasets: [
            {
              label: "Traffic Source",
              data: [1100, 1500, 2205],
              backgroundColor: [
                "rgba(255, 99, 132, 1)",
                "rgba(54, 162, 235, 1)",
                "rgba(255, 206, 86, 1)",
              ],
            },
          ],
        },
        options: { responsive: true },
      });

      chartInstance2.current = new Chart(ctx2, {
        type: "bar",
        data: {
          labels: [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
          ],
          datasets: [
            {
              label: "Earning",
              data: [
                4500, 4106, 7005, 6754, 5154, 4554, 7815, 3152, 12204, 4457, 8740, 11000
              ],
              backgroundColor: [
                "rgba(255, 99, 132, 1)", "rgba(54, 162, 235, 1)", "rgba(255, 206, 86, 1)",
                "rgba(75, 192, 192, 1)", "rgba(153, 102, 255, 1)", "rgba(255, 159, 64, 1)",
                "rgba(255, 99, 132, 1)", "rgba(54, 162, 235, 1)", "rgba(255, 206, 86, 1)",
                "rgba(75, 192, 192, 1)", "rgba(153, 102, 255, 1)", "rgba(255, 159, 64, 1)"
              ],
            },
          ],
        },
        options: { responsive: true },
      });
    }

    // Cleanup function: Hủy biểu đồ khi component bị unmount
    return () => {
      if (chartInstance1.current) chartInstance1.current.destroy();
      if (chartInstance2.current) chartInstance2.current.destroy();
    };
  }, []);

  return (
    <div className="graphBox" style={{ width: "1200px", height: "400px" }}>
      <div className="box">
        <canvas ref={chartRef1}></canvas>
      </div>
      <div className="box">
        <canvas ref={chartRef2}></canvas>
      </div>
    </div>
  );
};

export default Bieudo;
