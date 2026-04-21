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

usuario_input.send_keys(os.getenv("FORMULARIOS_USER"))
password_input.send_keys(os.getenv("CLAVE"))

# Botón login
login_btn = driver.find_element(By.CSS_SELECTOR, "button[type='submit']").click()

time.sleep(3)

# 4. Ir a REPORTES
wait = WebDriverWait(driver, 10)

reportes_btn = wait.until(
    EC.element_to_be_clickable(
        (By.XPATH, "//*[contains(text(),'Registrar') or contains(text(),'Reportes')]")
    )
)
reportes_btn.click()

time.sleep(7)

# 5. Rellenar formulario
driver.find_element(By.ID, "rut").send_keys("12345678-9")
driver.find_element(By.CSS_SELECTOR, "input[name='academica'][value='1']").click()

select = Select(driver.find_element(By.ID, "actividad"))
select.select_by_index(1) 

time.sleep(7)

driver.find_element(By.ID, "horas_totales").send_keys("10")
driver.find_element(By.ID, "about").send_keys("Actividad automatizada con Selenium")


time.sleep(7)

# 6. Enviar formulario
driver.find_element(By.XPATH, "//button[contains(text(),'Enviar Registro')]").click()

time.sleep(7)

# 7. Cerrar navegador
print("Test completado existosamente")
driver.quit()