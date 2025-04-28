import React, { useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import { useLoggedInUser } from '../hooks/useLoggedInUser';
import Login from './Login';

export const routeMap = {
  login: '/',
  dashboard: '/dashboard',
};

const AppRoutes = () => {
  const user = useLoggedInUser();

  useEffect(() => {
    // You could perform analytics or other actions when the page loads
  }, []);

  return (
    <Router>
      <Routes>
        <Route
          path={routeMap.login}
          element={user ? <Navigate to={routeMap.dashboard} /> : <Login />}
        />
        <Route path="*" element={<Navigate to={routeMap.login} />} />
      </Routes>
    </Router>
  );
};

export default AppRoutes;
