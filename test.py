from api import app 
import unittest
import warnings

class AppTests(unittest.TestCase):
    def setUp(self):
        app.config["TESTING"] = True
        self.app = app.test_client()

        warnings.simplefilter("ignore", category=DeprecationWarning)

    def test_index(self):
        response = self.app.get ("/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data.decode(), "<p>Hello, World</p>")

    def test_getcustomers(self):
        response = self.app.get("/customers")
        self.assertEqual(response.status_code, 200)
        self.assertTrue("Fabiola" in response.data.decode())

    
    def test_getcustomers_id(self):
        response = self.app.get("/customers/14")
        self.assertEqual(response.status_code, 200)
        self.assertTrue("Dasia" in response.data.decode())

if __name__ == "__main__":
    unittest.main()