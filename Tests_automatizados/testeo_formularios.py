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


def test_formulario():
    # 1. Inicializar navegador
    # --Chrome--
    # driver = webdriver.Chrome(service=ChromeService(ChromeDriverManager().install()))
    # --MS Edge--
    # edge_path = r"C:\Users\Instituto\Documents\Edge Webdriver\msedgedriver.exe"
    # service = EdgeService(executable_path=edge_path)
    # driver = webdriver.Edge(service=service)
    driver = webdriver.Edge()

    load_dotenv()

    try:
        print("[INFO] Iniciando prueba de formulario")

        # 2. Ir a la página
        driver.get("http://localhost:3001")  # cambia por tu URL

        time.sleep(2)

        # 3. LOGIN
        print("[TEST] Buscando campos de login")
        usuario_input = driver.find_element(By.ID, "correo")
        password_input = driver.find_element(By.ID, "password")

        usuario_input.send_keys(os.getenv("FORMULARIOS_USER"))
        password_input.send_keys(os.getenv("CLAVE"))

        print("[TEST] Verificando usuario ingresado.")
        assert usuario_input.get_attribute("value") == os.getenv("FORMULARIOS_USER"), \
            "El usuario no fue ingresado correctamente"
        print("[OK] Usuario ingresado correctamente")

        print("[TEST] Verificando contraseña ingresada")
        assert password_input.get_attribute("value") == os.getenv("CLAVE"), \
            "La contraseña no fue ingresada correctamente"
        print("[OK] Contraseña ingresada correctamente")

        # Botón login
        login_btn = driver.find_element(By.CSS_SELECTOR, "button[type='submit']").click()

        time.sleep(4)
        print("[TEST] Verificando redirección al dashboard...")
        assert "/dashboard" in driver.current_url, \
            f"No se redirigió al dashboard. URL actual: {driver.current_url}"
        print("[OK] Redirección al dashboard exitosa")

        # 4. Ir a REPORTES
        wait = WebDriverWait(driver, 10)

        reportes_btn = wait.until(
            EC.element_to_be_clickable(
                (By.XPATH, "//*[contains(text(),'Registrar') or contains(text(),'Reportes')]")
            )
        )
        assert reportes_btn.is_displayed()
        reportes_btn.click()

        time.sleep(7)

        # 5. Rellenar formulario
        print("[TEST] Ingresando RUT...")
        rut = driver.find_element(By.ID, "rut")
        rut.send_keys(os.getenv("RUT_FORMULARIOS"))

        assert rut.get_attribute("value") == os.getenv("RUT_FORMULARIOS"), \
            "El RUT ingresado no coincide con el esperado"
        print("[OK] RUT ingresado correctamente")

        print("[TEST] Seleccionando tipo académica...")
        driver.find_element(
            By.CSS_SELECTOR,
            "input[name='academica'][value='1']"
        ).click()
        print("[OK] Opción académica seleccionada")

        print("[TEST] Seleccionando actividad...")
        select = Select(driver.find_element(By.ID, "actividad"))
        select.select_by_index(1)
        print("[OK] Actividad seleccionada")

        time.sleep(7)

        print("[TEST] Ingresando horas...")
        horas = driver.find_element(By.ID, "horas_totales")
        horas.send_keys(os.getenv("HORAS"))

        assert horas.get_attribute("value") == os.getenv("HORAS"), \
            "Las horas ingresadas no coinciden"
        print("[OK] Horas ingresadas correctamente")

        print("[TEST] Ingresando descripción...")
        descripcion = driver.find_element(By.ID, "about")
        descripcion.send_keys(os.getenv("TEST_DESC"))

        assert descripcion.get_attribute("value") == os.getenv("TEST_DESC"), \
            "La descripción ingresada no coincide"
        print("[OK] Descripción ingresada correctamente")

        time.sleep(7)

        # 5. Enviar formulario
        print("[TEST] Enviando formulario...")
        driver.find_element(
            By.XPATH,
            "//button[contains(text(),'Enviar Registro')]"
        ).click()

        print("[TEST] Esperando mensaje de confirmación...")
        alert = wait.until(EC.alert_is_present())

        assert "Formulario guardado exitosamente" in alert.text, \
            f"Mensaje inesperado recibido: '{alert.text}'"
        print("[OK] Formulario guardado exitosamente")

        alert.accept()

        print("[INFO] Test completado exitosamente")

    finally:
        driver.quit()