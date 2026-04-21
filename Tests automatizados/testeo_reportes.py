from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
#from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.edge.service import Service as EdgeService
#from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.support.ui import Select
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import os
from dotenv import load_dotenv

# 1. Inicializar navegador
# --Chrome--
# driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))
# --MS Edge--
edge_path = r"C:\Users\Instituto\Documents\Edge Webdriver\msedgedriver.exe"
service = EdgeService(executable_path=edge_path)
driver = webdriver.Edge(service=service)

load_dotenv()

# 2. Ir a la página
driver.get("http://localhost:3001")  # cambia por tu URL

time.sleep(2)

# 3. LOGIN
usuario_input = driver.find_element(By.ID, "correo")
password_input = driver.find_element(By.ID, "password")

usuario_input.send_keys(os.getenv("REPORTES_USER"))
password_input.send_keys(os.getenv("CLAVE"))

# Botón login
driver.find_element(By.CSS_SELECTOR, "button[type='submit']").click()

time.sleep(3)

# 4. Ir a Reportes
wait = WebDriverWait(driver, 10)

reportes_btn = wait.until(
    EC.element_to_be_clickable(
        (By.XPATH, "//*[contains(text(),'Reportes')]")
    )
)
reportes_btn.click()

time.sleep(3)

# 5. Rellenar formulario
driver.find_element(By.CSS_SELECTOR, 'input[placeholder="Ej: 12.345.678-9"]').send_keys(os.getenv("RUT_REPORTES"))

time.sleep(3)

consultar_btn = wait.until(
    EC.element_to_be_clickable(
        (By.XPATH, "//button[contains(.,'Consultar')]")
    )
)
consultar_btn.click()

time.sleep(3)

# 6. Esperar a que lleguen datos y descargar csv
wait.until(
    EC.presence_of_element_located((By.XPATH, "//button[contains(text(),'CSV')]"))
)

csv_btn = driver.find_element(By.XPATH, "//button[contains(text(),'CSV')]")
csv_btn.click()

time.sleep(7)

# 7. Cerrar navegador
print("Test completado existosamente")
driver.quit()