#import "Reprocessing.h"
#import <OpenGLES/ES2/glext.h>

extern void reasonglMain(ReprocessingViewController *this);
extern void reasonglUpdate(ReprocessingViewController *this);
extern void reasonglTouchPress(double x, double y);
extern void reasonglTouchRelease(double x, double y);
extern void reasonglTouchDrag(double x, double y);

@interface ReprocessingViewController ()

- (void)tearDownGL;

@end

@implementation ReprocessingViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	reasonglMain(self);
}

- (void)dealloc
{
	[self tearDownGL];

	if ([EAGLContext currentContext] == self.context) {
		[EAGLContext setCurrentContext:nil];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];

	if ([self isViewLoaded] && ([[self view] window] == nil)) {
		self.view = nil;

		[self tearDownGL];

		if ([EAGLContext currentContext] == self.context) {
			[EAGLContext setCurrentContext:nil];
		}
		self.context = nil;
	}

	// Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

- (void)tearDownGL {
	[EAGLContext setCurrentContext:self.context];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	UITouch* touchEvent = [touches anyObject];
	CGPoint locationInView = [touchEvent locationInView:self.view];
	reasonglTouchPress(locationInView.x, locationInView.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches withEvent:event];
	UITouch* touchEvent = [touches anyObject];
	CGPoint locationInView = [touchEvent locationInView:self.view];
	reasonglTouchDrag(locationInView.x, locationInView.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];
	UITouch* touchEvent = [touches anyObject];
	CGPoint locationInView = [touchEvent locationInView:self.view];
	reasonglTouchRelease(locationInView.x, locationInView.y);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesCancelled:touches withEvent:event];
}

- (void)update {
	reasonglUpdate(self);
}

@end
