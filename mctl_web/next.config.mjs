/** @type {import('next').NextConfig} */

export default {
    webpack: (config, { isServer }) => {
      if (!isServer) {
        // Configure webpack to handle binary files
        config.module.rules.push({
          test: /\.(png|jpe?g|gif|woff|woff2|eot|ttf|otf|svg|pdf)$/,
          use: [
            {
              loader: 'file-loader',
              options: {
                publicPath: '/_next',
                name: 'static/media/[name].[hash].[ext]',
              },
            },
          ],
        });
      }
  
      return config;
    },
  };
  