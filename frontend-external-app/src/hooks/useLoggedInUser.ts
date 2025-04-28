// src/hooks/useLoggedInUser.ts
import { useState, useEffect } from 'react';

export const useLoggedInUser = () => {
  const [user, setUser] = useState<any>(null);

  useEffect(() => {
    // Check if a user is stored in localStorage or sessionStorage
    const loggedInUser = localStorage.getItem('user');

    if (loggedInUser) {
      setUser(JSON.parse(loggedInUser));
    }
  }, []);

  return user;
};
