import {
  ApolloClient,
  InMemoryCache,
  ServerParseError,
  ServerError,
  ApolloLink,
} from '@apollo/client';
import { onError } from '@apollo/client/link/error';
import { HttpLink } from '@apollo/client/link/http';
import { GraphQLFormattedError } from 'graphql';

import { LogoutDocument } from './graphqlTypes';
import navigateToLogin from '../pages/routes';

const possibleTypes = {
  Node: ['Orgnization', 'Athlete', 'Event'],
};

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

const httpLink = new HttpLink({
  uri: `${API_BASE_URL}/graphql`,
  credentials: 'include',
});

const onNetworkErrorHandlers: ((
  error: Error | ServerError | ServerParseError
) => void)[] = [];
const onGraphQLErrorHandlers: ((error: GraphQLFormattedError) => void)[] = [];

export const subscribeToNetworkErrors = (
  handler: (error: Error | ServerError | ServerParseError) => void
) => {
  onNetworkErrorHandlers.push(handler);
};

export const subscribeToGraphQLErrors = (
  handler: (error: GraphQLFormattedError) => void
) => {
  onGraphQLErrorHandlers.push(handler);
};

subscribeToGraphQLErrors(error => {
  if (error.message === 'Not Authorized') {
    console.log('Logging out due to Not Authorized response');
    apolloLogOut();
  }
});

let isLoggingOut = false;

const errorLink = onError(
  ({ operation, response, graphQLErrors, networkError }) => {
    if (isLoggingOut && operation?.operationName !== 'deleteSession') {
      console.log('Ignoring errors while logging out');

      if (response) {
        response.errors = undefined;
      }
      return;
    }
    if (graphQLErrors?.length) {
      graphQLErrors.forEach(error => {
        onGraphQLErrorHandlers.forEach(handler => handler(error as GraphQLFormattedError));
      });
    }
    if (networkError) {
      onNetworkErrorHandlers.forEach(handler => handler(networkError));
    }
  }
);

const link = ApolloLink.from([errorLink, httpLink]);

const cache = new InMemoryCache({
  possibleTypes,
});

export const client = new ApolloClient({
  link,
  cache,
});

export const apolloLogOut = async () => {
  isLoggingOut = true;

  try {
    await client.mutate({ mutation: LogoutDocument });
  } catch (error) {
    console.error('Error during logout mutation:', error);
  } finally {
    client.stop();
    navigateToLogin();
  }
};
