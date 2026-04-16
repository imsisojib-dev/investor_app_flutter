import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/shared/theme/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/shared/theme/app_theme_extension.dart';

class VideoCardAdvanced extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final String title;
  final VoidCallback? onTap;

  const VideoCardAdvanced({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
    required this.title,
    this.onTap,
  });

  @override
  State<VideoCardAdvanced> createState() =>
      _VideoCardAdvancedState();
}

class _VideoCardAdvancedState extends State<VideoCardAdvanced> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _showThumbnail = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: false,
        looping: false,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        showControlsOnInitialize: false,
        fullScreenByDefault: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color(0xff00BA63),
          handleColor: const Color(0xff00BA63),
          backgroundColor: Colors.grey.shade300,
          bufferedColor: Colors.grey.shade400,
        ),
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00BA63)),
            ),
          ),
        ),
      );

      // Listen to play/pause state
      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.isPlaying && _showThumbnail) {
          setState(() {
            _showThumbnail = false;
          });
        }
      });

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _playVideo() {
    setState(() {
      _showThumbnail = false;
    });
    _videoPlayerController?.play();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(
          left: 8.w,
          right: 8.w,
          bottom: 4.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Video Player Section
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildVideoSection(theme),
            ),

            // Campaign Details Section
            _buildDetailsSection(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoSection(ThemeData theme) {
    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video Player or Error
          if (_hasError)
            _buildErrorWidget(theme)
          else if (!_isInitialized || _chewieController == null)
            _buildLoadingWidget()
          else
            Chewie(controller: _chewieController!),

          // Thumbnail Overlay
          if (_showThumbnail && !_hasError && _isInitialized)
            _buildThumbnailOverlay(),

          // Play Button Overlay (only on thumbnail)
          if (_showThumbnail && !_hasError && _isInitialized)
            _buildPlayButton(),
        ],
      ),
    );
  }

  Widget _buildThumbnailOverlay() {
    if (widget.thumbnailUrl == null) {
      return Container(color: Colors.black);
    }

    return Image.network(
      widget.thumbnailUrl!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.black,
          child: const Icon(
            Icons.videocam,
            color: Colors.white54,
            size: 48,
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00BA63)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayButton() {
    return Center(
      child: GestureDetector(
        onTap: _playVideo,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00BA63)),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(ThemeData theme) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 4),
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              'Failed to load video',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: WidgetStatePropertyAll(Size(100, 16),),
              ),
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _isInitialized = false;
                });
                _initializePlayer();
              },
              child: Text(
                'Retry',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.title,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.appColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ).padding(EdgeInsets.symmetric(horizontal: 8.w)),
        const SizedBox(height: 4),
      ],
    );
  }
}