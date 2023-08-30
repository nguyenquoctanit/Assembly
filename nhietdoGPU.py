import pynvml
import time

# Khởi tạo thư viện
pynvml.nvmlInit()

info = 71
while info > 70:
    handle = pynvml.nvmlDeviceGetHandleByIndex(1)
    info = pynvml.nvmlDeviceGetTemperature(handle, pynvml.NVML_TEMPERATURE_GPU)
    print(f"GPU 1: {info} độ C")
    time.sleep(3)
pynvml.nvmlShutdown()