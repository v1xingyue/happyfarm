import 'tailwindcss/tailwind.css';
import '../css/font-awesome.css';
import '../css/user.css';
import type { AppProps } from 'next/app';

function MyApp({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />;
}

export default MyApp;
