const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;
const APP_ENV = import.meta.env.VITE_APP_ENV;

export const fetchUser = async (id: string) => {
  const response = await fetch(`${API_BASE_URL}/users/${id}`);
  const data = await response.json();
  console.log(`Fetched from ${APP_ENV} environment`);
  return data;
};
